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

	/**
	 * @method GET
	 * @provides application/json
	 */
	public function get() {
		
		// shared DB connection
		$db = $this->container['db'];

		// list all products
		$query = $db->query("SELECT * FROM products");
		$products = $query->fetchAll(\PDO::FETCH_OBJ);

		/*
		foreach ($query->fetchAll(\PDO::FETCH_OBJ) as $product) {
			echo Pre::r($product);
		}*/
		return new Response(Response::OK, json_encode($products), array('content-type' => 'application/json'));
	}
	
	
	/**
	 * @method POST
	 * @provides application/json
	 */
	public function sync() {

		// shopify API client
		$shopify = $this->container['shopify'];

		try {

			// $this->request->data

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