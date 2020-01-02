<?php

namespace Core\Http;

/**
 * Class Response
 *
 * Takes data from the application and returns it in JSON format
 */
class Response {

    /**
     * Return headers
     * @var array
     */
    protected $headers = [];

    /**
     * Content to be returned
     * @var
     */
    protected $content;

    /**
     * Response codes and status text
     * (Just a few for the sake of this project.)
     *
     * @var array
     */
    protected $statuses = [
        200 => 'OK',
        400 => 'Bad Request',
        404 => 'Not Found',
        500 => 'Internal Server Error',
        ];

    /**
     * Response constructor
     * 
     * Setting the default headers
     */
    public function __construct()
    {
        $this->setHeader('Access-Control-Allow-Origin: *');
        $this->setHeader('Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE');
        $this->setHeader('Content-Type: application/json; charset=UTF-8');
    }

    /**
     * Set content response
     *
     * @param $content
     */
    public function setContent($content) {
        $this->content = json_encode($content);
    }

    /**
     * Set header
     *
     * @param $header
     */
    public function setHeader($header) {
        $this->headers[] = $header;
    }

    /**
    * Set the response status
    * @param int $code
    */
    public function setStatus($code) {
        if (array_key_exists($code,$this->statuses)) {
            $this->setHeader(sprintf('HTTP/1.1 ' . $code . ' %s' , $this->statuses[$code]));
        }
    }

    /**
     *  Renders the output
     */
    public function render() {
        if ($this->content) {
            $output = $this->content;
            if (!headers_sent()) {
                foreach ($this->headers as $header) {
                    header($header, true);
                }
            }
            echo $output;
        }
    }
}
