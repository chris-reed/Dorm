<?php


namespace Core\Parents;

/**
* Parent class for Controllers
*
*/
class Controller
{
    /**
     * Request class
     * @var \Core\Http\Request
     */
    protected $request;

    /**
     * Response class
     * @var \Core\Http\Response
     */
    protected $response;

    /**
     * Instance of the Model associated with the child Controller 
     * @var \Models\
     */
    protected $model;

    /**
    * Class constructor
    *
    * Determines the child controller's associated model then
    * loads the request, response, and model variables
    */
    public function __construct()
    {
        $model = 'Model'.str_replace('Controller','',static::class);
        $this->request = $GLOBALS['request'];
        $this->response = $GLOBALS['response'];
        $this->model = new $model;
    }

    /**
     * Just a shorthand method to send a response
     *
     * @param int $status
     * @param $content
     */
    public function response($content,$status = 200) {
        $this->response->setStatus($status);
        $this->response->setContent($content);
    }

}
