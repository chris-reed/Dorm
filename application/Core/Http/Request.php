<?php

namespace Core\Http;

/**
 * Class Request
 * @package Core\Http
 *
 * Super barebones request handler.
 */
class Request
{
    public $request;

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
            // return formatted value or null if nonexistent.
            return isset($_POST[$key]) ? $this->prepare($_POST[$key]) : null;
        }
        // return entire request formatted if no key is entered.
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