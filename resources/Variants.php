<?php

namespace Camazon;

use Tonic\Resource,
    Tonic\Response,
    Tonic\ConditionException,
    sandeepshetty\shopify_api;
	
	
/**
 * Single Variant resource
 * @uri /variants/([0-9]+)
 */
class Variant extends Resource {
	
	/**
	 * @method GET
	 * @provides application/json
	 */
	public function get($variant_id = NULL) {
		
		// no variant id specified
		if (empty($variant_id))
			return new Response(404, 'You must specify a variant ID.');
		
		// retrieve full variant details
		$query = \App::$container['db']->query("SELECT * FROM products_variants WHERE variant_id = '$variant_id' LIMIT 1");
		$variant = $query->fetch(\PDO::FETCH_ASSOC);

		// JSON response
		return new Response(Response::OK, json_encode($variant), array('content-type' => 'application/json'));
	}
	
	/**
	 * @method PUT
	 * @accepts application/json
	 * @provides application/json
	 */
	
	// {"inventory_quantity":"23", "updated_at":"2013-07-12T03:19:10-07:00"}
	public function post($variant_id = NULL) {
		
		// no variant id specified
		if (empty($variant_id))
			return new Response(404, 'You must specify a variant ID.');
		
		// accepts JSON 
		$data = json_decode($this->request->data, TRUE);
		
		// no valid data
		if (empty($data))
			return new Response(400, 'You must provide variant data to update.');

		// update variant
		$query = 'UPDATE products_variants SET ';
		foreach($data as $key => $val)
			if (in_array($key, Variants::$variants_fields))
				$query .= "{$key} = :{$key}, ";
		$query = substr($query, 0, -2)." WHERE variant_id = '$variant_id' LIMIT 1";

		// prepare update query
		$query = \App::$container['db']->prepare($query);
		foreach($data as $key => $val) {
			if (in_array($key, Variants::$variants_fields)) {
				// format dates
				if ($key == 'created_at' OR $key == 'updated_at')
					$val = strtotime($val);
				// bind value
				$query->bindValue(":{$key}", $val);
			}
		}
		
		// execute query
		$query->execute();
		
		// retrieve full variant details
		$query = \App::$container['db']->query("SELECT * FROM products_variants WHERE variant_id = '$variant_id' LIMIT 1");
		$variant = $query->fetch(\PDO::FETCH_ASSOC);
		
		// JSON response
		return new Response(Response::OK, json_encode($variant), array('content-type' => 'application/json'));
	}
}	
	
/**
 * Variants resource
 * @uri /variants
 */
class Variants extends Resource {

	// basic cache of variants
	private static $_variants = array();
	
	// local DB fields
	public static $variants_fields = array('product_id', 'variant_id', 'created_at', 'updated_at', 'position', 'title', 'sku', 'option1', 'option2', 'option3', 'inventory_quantity', 'price', 'grams');

	/**
	 * @method GET
	 * @provides application/json
	 */
	public function get() {

		// get all variants from cache
		$variants = self::cached();

		// JSON response
		return new Response(Response::OK, json_encode($variants), array('content-type' => 'application/json'));
	}
	
	
	// handle updating variants
	public static function _sync_variants(&$shopify_variants) {
		
		$response = '';
		
		// no variants to sync
		if (empty($shopify_variants) OR ! is_array($shopify_variants))
			return;
		
		// get cached DB variants
		$db_variants = self::cached(NULL);
		
		// compare against Shopify variants
		$inserts = array(); // new variants to add
		$updates = array(); // variants to update
		foreach ($shopify_variants as $pid => $product_variants) {
			foreach ($product_variants as &$variant) {
				
				// shopify variant id, map to our DB column
				$vid = $variant['id'];
				$variant['variant_id'] = $vid;
				
				if (isset($db_variants[$vid])) {
					foreach (self::$variants_fields as $field) {
					
						// date format to unix timestamp
						$shopify_value = ($field == 'created_at' OR $field == 'updated_at') ? strtotime($variant[$field]) : $variant[$field];
					
						// fields don't match
						if ($shopify_value != $db_variants[$vid][$field]) {
							// record mismatch
							$response .= \Paste\Pre::r(array($shopify_value, $db_variants[$vid][$field]), $variant['id'].': '.$field.' MISMATCH');
							$updates[$vid] = &$db_variants[$vid];
							break;
						}
					}
				// we don't have this variant, create it
				} else {
			
					// add to local DB
					$inserts[$vid] = &$variant;
				}
			}
		}
		
		// update variants
		foreach ($updates as $vid => &$variant)
			self::_update_variant($variant);
		
		// add variants
		foreach ($inserts as $vid => &$variant)
			self::_update_variant($variant, TRUE);
		
		// debug only
		return $response;
		
	}
	
	// update or insert a product in the DB
	public static function _update_variant(&$variant, $insert = FALSE) {
		
		// insert variant
		if ($insert) {
			$keys = '';
			$values = '';
			foreach($variant as $key => $val) {
				if (in_array($key, self::$variants_fields)) {
					$keys .= "{$key}, ";
					$values .= ":{$key}, ";
				}
			}
			$query = "INSERT INTO products_variants (".substr($keys, 0, -2).") VALUES (".substr($values, 0, -2).")";

		} else {

			// update variant
			$set = '';
			foreach($variant as $key => $val)
				if (in_array($key, self::$variants_fields))
					$set .= "{$key} = :{$key}, ";
			$query = "UPDATE products_variants SET ".substr($set, 0, -2)." WHERE variant_id = '".$variant['variant_id']."' LIMIT 1";
			
		}

		// prepare update query
		$query = \App::$container['db']->prepare($query);
		foreach($variant as $key => $val) {
			if (in_array($key, self::$variants_fields)) {
				// format dates
				if ($key == 'created_at' OR $key == 'updated_at')
					$val = strtotime($val);
				// bind value
				$query->bindValue(":{$key}", $val);
			}
		}
		
		// execute query and update/insert variant
		$query->execute();
		
	}
	
	
	// variant cache
	public static function cached($variant_id = NULL) {
		
		// cache variants
		if (empty(self::$_variants)) {
			
			// retrieve full variant details
			$query = \App::$container['db']->query("SELECT * FROM products_variants ORDER BY variant_id DESC");
			$variants = $query->fetchAll(\PDO::FETCH_ASSOC);

			foreach ($variants as &$variant) {
				
				// array of variant options for convenience
				$variant['_options'] = array();
				
				// try to get up to 10 options
				for ($o = 1; $o <= 10; $o++) {
					
					$opt = @$variant['option'.$o];
					
					// add to array
					if (! empty($opt))
						$variant['_options'][] = $opt;
					
				}
			
				self::$_variants[$variant['variant_id']] = &$variant;
			}
		
		}
		
		// return variant if variant_id is specified
		if (! empty($variant_id)) {
			
			// return our cached variant if we could find it
			return (isset(self::$_variants[$variant_id])) ? self::$_variants[$variant_id] : FALSE;
		}

		// otherwise return all variants
		return self::$_variants;
		
	}

}


