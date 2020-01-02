<?php

namespace Core\Http;

/**
 * Request class
 *
 * A very simple request handler
 */
class Request
{
    /**
    * Request data
    * @var
    */
    public $request;

    /**
    * Class constructor
    * 
    * Loads the request variable
    */
    public function __construct()
    {
        $this->request = $_REQUEST;
    }

    /**
     * Returns formatted and cleaned request value.
     * @param string $key
     * @return array|string|null
     */
    public function get(string $key = '') {
        if($key !== '') {
            return isset($_POST[$key]) ? $this->prepare($_POST[$key]) : null;
        }
        return  $this->prepare($_POST);
    }

    /**
     * scrub request data
     * @param $data
     * @return array|string
     */
    private function prepare($data) {
        if (is_array($data)) {
            foreach ($data as $key => $value) {
                unset($data[$key]);
                $data[$this->prepare($key)] = $this->prepare($value);
            }
        } else {
            $data = htmlspecialchars($data);
        }
        return $data;
    }

}
