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
class Variants extends Resource {
	
	// local DB fields
	public static $variants_fields = array('product_id', 'variant_id', 'created_at', 'updated_at', 'position', 'title', 'sku', 'option1', 'option2', 'option3', 'inventory_quantity', 'price', 'grams');
	
	/**
	 * @method GET
	 * @provides application/json
	 */
	public function get($variant_id = NULL) {
		
		// no variant id specified
		if (empty($variant_id))
			return new Response(404, 'You must specify a variant ID.');
		
		// get single variant
		$query = $this->container['db']->query("SELECT * FROM products_variants WHERE variant_id = '$variant_id' LIMIT 1");
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
			if (in_array($key, self::$variants_fields))
				$query .= "{$key} = :{$key}, ";
		$query = substr($query, 0, -2)." WHERE variant_id = '$variant_id' LIMIT 1";

		// prepare update query
		$query = $this->container['db']->prepare($query);
		foreach($data as $key => $val) {
			if (in_array($key, self::$variants_fields)) {
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
		$query = $this->container['db']->query("SELECT * FROM products_variants WHERE variant_id = '$variant_id' LIMIT 1");
		$variant = $query->fetch(\PDO::FETCH_ASSOC);
		
		// JSON response
		return new Response(Response::OK, json_encode($variant), array('content-type' => 'application/json'));
	}

}


