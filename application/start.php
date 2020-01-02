<?php
use Core\Router;

require 'config.php';
require 'autoload.php';

// Instantiate Return and Respose classes
$request = new \Core\Http\Request();
$response = new \Core\Http\Response();

// Start the application
$app = new Router();
$app->run();

// Return the response
$response->render();


