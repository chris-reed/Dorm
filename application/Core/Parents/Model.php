<?php

namespace Core\Parents;

use Core\DB;

/**
* Parent class for Models
*
*/
class Model
{
    /**
    * instance of the database Class
    * @var \Core\DB
    */
    public $db;

    /**
    * Class constructor
    *
    * loads the db variable
    */
    public function __construct()
    {
        $this->db = new DB();
    }

    /**
     * Retrievs all data from the child Models table
     * @return array
     */
    public function getAll() {
        return $this->db->getAllFromTable($this->table);
    }
    /**
     * Finds all data from the child Models table given ids
     * @return array
     */
    public function find($id){
        return $this->db->find($this->table,$id);
    }

    /**
     * Given an associative multidimensional array and a key name,
     * it reruns an single array of values or single value
     *
     * @param $field
     * @param array $array
     * @param $option
     * @return mixed
     */
    function pluck($field, array $array) {
        return array_column($array,$field);
    }

}
