<?php

namespace Camerazon;

use Tonic\Resource,
    Tonic\Response,
    Tonic\ConditionException,
    sandeepshetty\shopify_api;
	
	
/**
 * Combos resource
 * @uri /combos
 */
class Combos extends Resource {
	
	/**
	 * @ method GET
	 * @ provides application/json
	 */
	private function populate() {
		
		// shopify API client
		$shopify = \App::$container['shopify'];
		
		$colors = array('Red', 'Blue', 'Green', 'Purple', 'Black');
		$sizes = array('Child', 'Small', 'Medium', 'Large', 'X-Large');
		
		$response = '';
		for ($p = 1; $p <= 12; $p++) {

			$rand = rand(100, 999);
			shuffle($colors);
			shuffle($sizes);
			
			// creation fields
			$product = array(
				'product' => array(
					'title' => 'Amazing Random Product #'.$rand, 
					'body_html' => 'Really Great Product #'.$rand.'',
					'vendor' => 'Camerazon', 
					'product_type' => 'Randoms', 
					'images' => array(
						array('src' => 'https://cdn.shopify.com/s/files/1/0249/1755/products/canon-wide_grande.jpg?10'),
					),
					'options' => array(
						array('name' => 'Color'),
						array('name' => 'Size'),
					),
					'variants' => array(),
				),
			);
		
			$num_variants = rand(3,10);
			for ($i = 0; $i <= 4; $i++) {
				
				$rand2 = rand(100, 999);
				
				$product['product']['variants'][] = array(
					'title' => 'Randoms #'.$rand2,
					'option1' => $colors[$i],
					'option2' => $sizes[$i],
					'price' => rand(20, 100).".00",
					'sku' => 'randoms-'.$rand2,
				);
			};


			// echo \Paste\Pre::r($product);

			// insert product
			$result = $shopify('POST', '/admin/products.json', $product, $response_headers);
		
			$response .= \Paste\Pre::r($result, 'RESULT');
			$response .= \Paste\Pre::r($response_headers, 'response_headers');			
		}
		
		return new Response(Response::OK, $response, array('content-type' => 'text/html'));
	}
}


