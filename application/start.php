<?php
use Core\Router;
require 'config.php';
require 'autoload.php';

$request = new \Core\Http\Request();
$response = new \Core\Http\Response();

//Start the application
$app = new Router();
$app->run();

//return the response
$response->render();


