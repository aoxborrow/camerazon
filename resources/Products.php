<?php

namespace Camazon;

use Tonic\Resource,
    Tonic\Response,
    Tonic\ConditionException,
    sandeepshetty\shopify_api;

/**
 * Products resource
 * @uri /products
 */
class Products extends Resource {
	
	// local DB fields
	public static $products_fields = array('product_id', 'created_at', 'updated_at', 'product_type', 'vendor', 'handle', 'title', 'body_html');
	
	/**
	 * @method GET
	 * @provides application/json
	 */
	public function get() {
		
		// list all products
		$query = $this->container['db']->query("SELECT * FROM products");
		$products = $query->fetchAll(\PDO::FETCH_ASSOC);

		// JSON response
		return new Response(Response::OK, json_encode($products), array('content-type' => 'application/json'));
	}
	
	
	/**
	 * Post a new product and sync DB with Shopify
	 * @method POST
	 * @provides application/json
	 */
	public function post() {
		
		// accepts JSON 
		$data = json_decode($this->request->data, TRUE);
		
		// shopify API client
		$shopify = $this->container['shopify'];

		try {

			// api request params
			$request_params = array();

			// list products
			$products = $shopify('GET', '/admin/products.json', $request_params, $response_headers);
			
			// UPDATE DB, RETURN NEW PRODUCTS
			
			$response = $products;
	
			// API call limit helpers
			// echo shopify_api\calls_made($response_headers); // 2
			// echo shopify_api\calls_left($response_headers); // 298
			// echo shopify_api\call_limit($response_headers); // 300

		} catch (shopify_api\Exception $e) {
	
			$response = $e->getInfo();
	
		} catch (shopify_api\CurlException $e) {
	
			$response = $e->getMessage();
	
		}
		
		// return product list
		return new Response(Response::CREATED, json_encode($response), array('content-type' => 'application/json'));
	}
}


/**
 * Single Product resource
 * @uri /products/([0-9]+)
 */
class Product extends Resource {
	
	/**
	 * @method GET
	 * @provides application/json
	 */
	public function get($product_id = NULL) {
		
		// no product id specified
		if (empty($product_id))
			return new Response(404, 'You must specify a product ID.');

		// get product data
		$query = $this->container['db']->query("SELECT * FROM products WHERE product_id = '$product_id' LIMIT 1");
		$product = $query->fetch(\PDO::FETCH_ASSOC);

		// product not found
		if (empty($product))
			return new Response(404, 'Product ID not found.');
		
		// get variants for a product, order by last updated
		$query = $this->container['db']->query("SELECT * FROM products_variants WHERE product_id = '$product_id' ORDER BY updated_at");
		$variants = $query->fetchAll(\PDO::FETCH_ASSOC);
		
		// return in same format as Shopify API
		$product['variants'] = $variants;

		// JSON response
		return new Response(Response::OK, json_encode($product), array('content-type' => 'application/json'));
	}
}


/**
 * Variants resource
 * @uri /products/([0-9]+)/variants
 */
class ProductVariants extends Resource {
	
	/**
	 * @method GET
	 * @provides application/json
	 */
	public function get($product_id = NULL) {
		
		// no product id specified
		if (empty($product_id))
			return new Response(404, 'You must specify a product ID.');
		
		// get variants for a product, order by last updated
		$query = $this->container['db']->query("SELECT * FROM products_variants WHERE product_id = '$product_id' ORDER BY updated_at");
		$variants = $query->fetchAll(\PDO::FETCH_ASSOC);

		// JSON response
		return new Response(Response::OK, json_encode($variants), array('content-type' => 'application/json'));
	}

}


