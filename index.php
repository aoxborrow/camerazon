<?php

// setup error reporting
error_reporting(E_ALL);
ini_set('display_errors', TRUE);

// composer autoload
require 'vendor/autoload.php';

// Shopify private app config
define('SHOPIFY_DOMAIN', 'camazon.myshopify.com');
define('SHOPIFY_API_KEY', '621334bb86409fde4f720750cf2e9e07');
define('SHOPIFY_PASSWORD', '144fea74c3900c0271a599146de473ee');
define('SHOPIFY_SECRET', 'd4c6f1287d7d0da2addba3421a00871c');

// MySQL config
define('MYSQL_HOST', '127.0.0.1');
define('MYSQL_USER', 'root');
define('MYSQL_PASS', '1234');
define('MYSQL_DB', 'camerazon');

// cheap hack to make Tonic\Application work more like a singleton for dependency injection
class App extends Tonic\Application {
	public static $container; // Pimple DI
}

// configure Tonic framework
// https://github.com/peej/tonic
$tonic_config = array(
	'load' => array('resources/*.php'), // load resource classes for Tonic
	'mount' => array('Camerazon' => '/api'), // mount namespaced resources at /api
	// 'cache' => new Tonic\MetadataCacheFile('/tmp/tonic.cache'), // use the metadata cache
);

// init Tonic
$tonic = new App($tonic_config);
$request = new Tonic\Request(array('baseUri' => '/api'));

// for API Index, just show a simple overview
if ($request->uri === '/api/')
	// load API index file and exit
	die(include('source/api.html'));

try {

	// map to and instantiate resource
	$resource = $tonic->getResource($request);
	
	// set up a DI container for DB connection & Shopify API
	\App::$container = new Pimple();
	\App::$container['db'] = \App::$container->share(function($c) {
		// PDO connector
		return new \PDO("mysql:host=".MYSQL_HOST.";dbname=".MYSQL_DB, MYSQL_USER, MYSQL_PASS);
	});

	// add Shopify API service
	\App::$container['shopify'] = \App::$container->share(function($c) {
		// Shopify client
		return sandeepshetty\shopify_api\client(SHOPIFY_DOMAIN, NULL, SHOPIFY_API_KEY, SHOPIFY_PASSWORD, TRUE);
	});
	
	// generate response from resource
	$response = $resource->exec();

} catch (Tonic\NotFoundException $e) {
	$response = new Tonic\Response(404, $e->getMessage());

} catch (Tonic\Exception $e) {
	$response = new Tonic\Response($e->getCode(), $e->getMessage());
}

// HTTP response
$response->output();

