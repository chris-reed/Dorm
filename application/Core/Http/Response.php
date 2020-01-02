<?php

namespace Core\Http;

/**
 * Class Response
 */
class Response {

    /**
     * @var array
     */
    protected $headers = [];

    /**
     * @var
     */
    protected $content;

    /**
     * Just a few for the sake of this project.
     * @var
     */
    protected $statuses = [
        200 => 'OK',
        400 => 'Bad Request',
        404 => 'Not Found',
        500 => 'Internal Server Error',
        ];

    /**
     * Response constructor.
     * Setting the default headers
     */
    public function __construct()
    {
        $this->setHeader('Access-Control-Allow-Origin: *');
        $this->setHeader('Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE');
        $this->setHeader('Content-Type: application/json; charset=UTF-8');
    }

    /**
     *  Set content response.
     *
     * @param $content
     */
    public function setContent($content) {
        $this->content = json_encode($content);
    }

    /**
     *  Set header.
     *
     * @param $header
     */
    public function setHeader($header) {
        $this->headers[] = $header;
    }

    public function setStatus($code) {
        if (array_key_exists($code,$this->statuses)) {
            $this->setHeader(sprintf('HTTP/1.1 ' . $code . ' %s' , $this->statuses[$code]));
        }
    }
    /**
     *  Render Output
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
