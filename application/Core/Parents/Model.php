<?php

namespace Core\Parents;

use Core\DB;

class Model
{
    public $db;

    public function __construct()
    {
        $this->db = new DB();
    }

    /**
     * @return array
     */
    public function getAll() {
        return $this->db->getAllFromTable($this->table);
    }
    public function find($id){
        return $this->db->find($this->table,$id);
    }
    /**
     * Given an associative multidimensional array and a key name,
     * it reruns an single array of values or single value
     * @param $field
     * @param array $array
     * @param $option
     * @return mixed
     */
    function pluck($field, array $array) {
        return array_column($array,$field);
    }

}