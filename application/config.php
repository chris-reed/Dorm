<?php
/**
 *  Application/Database config file
 *
 */

//application configuration
define('ROOT', str_replace('\\', '/', rtrim(__DIR__, '/')) . '/');
define('CORE', ROOT . 'Core/');
define('CONTROLLERS', ROOT . 'Controllers/');
define('MODELS', ROOT . 'Models/');

// Database configuration
define('DATABASE', [
    'port' => '3306',
    'host' => 'localhost',
    'schema' => 'chris_reed',
    'user' => 'creed',
    'password' => 'creed',
    'options' => [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ],
]);
