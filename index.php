<?php

// setup error reporting
error_reporting(E_ALL);
ini_set('display_errors', TRUE);

// composer autoload
require 'vendor/autoload.php';

// shopify api lib
use sandeepshetty\shopify_api;

// Pre debug output
use Paste\Pre;

// Shopify private app config
$shopify_domain = 'camazon.myshopify.com';
$api_key = '621334bb86409fde4f720750cf2e9e07';
$password = '144fea74c3900c0271a599146de473ee';
$secret = 'd4c6f1287d7d0da2addba3421a00871c';
// e.g: https://apikey:password@camazon.myshopify.com/admin/orders.xml


// init client
$shopify = shopify_api\client($shopify_domain, NULL, $api_key, $password, true);

try {

	// api request params
	$request_params = array();

	// list products
	$products = $shopify('GET', '/admin/products.json', $request_params, $response_headers);
	
	// take a look
	echo Pre::r($products);

	// API call limit helpers
	// echo shopify_api\calls_made($response_headers); // 2
	// echo shopify_api\calls_left($response_headers); // 298
	// echo shopify_api\call_limit($response_headers); // 300

} catch (shopify_api\Exception $e) {
	
	print_r($e->getInfo());
	
	/* $e->getInfo() will return an array with keys:
	* method
	* path
	* params (third parameter passed to $shopify)
	* response_headers
	* response
	* shops_myshopify_domain
	* shops_token
	*/
} catch (shopify_api\CurlException $e) {
	
	print_r($e->getMessage());
	
	// $e->getMessage() returns value of curl_error() and $e->getCode() returns value of curl_errno()
}