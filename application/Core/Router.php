<?php

namespace Core;
use Controllers\DormitoryController;
/**
 * Class Router
 * Routes application requests
 */
class Router
{
    private $request;

    public function __construct()
    {
        $this->request = $GLOBALS['request'];
    }

    /**
     * Routes the ajax request to the proper Controller and method
     * @return string
     */
    public function run()
    {
        $action = $this->getRoute($this->request->get('route'));
        if($action && file_exists($action->file)) {
            include $action->file;
            $app = new $action->controller;
            $method = $action->method;
            if(method_exists($app,$method)){
                $app->$method();
            }
        }
        return json_encode(['error' => 'Controller not found', 'request' => $this->request]);
    }
    private function getRoute($request){
        $routes = explode('@',$request);
        if(count($routes) !== 2){
            return null;
        }
        $class = $routes[0].'Controller';
        return (object) [
            'controller' => "Controllers\\$class",
            'method' => $routes[1],
            'file' => CONTROLLERS.$class.'.php',
        ];
    }
}