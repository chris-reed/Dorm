<?php


namespace Core\Parents;


class Controller
{
    /**
     * Request class
     */
    protected $request;
    /**
     * Response class
     */
    protected $response;
    /**
     * Model Instance
     */
    protected $model;

    public function __construct()
    {
        $model = 'Model'.str_replace('Controller','',static::class);
        $this->request = $GLOBALS['request'];
        $this->response = $GLOBALS['response'];
        $this->model = new $model;
    }

    /**
     * Response shorthand
     * @param int $status
     * @param $content
     */
    public function response($content,$status = 200) {
        $this->response->setStatus($status);
        $this->response->setContent($content);
    }

}