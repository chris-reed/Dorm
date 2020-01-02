<?php

namespace Core;
/**
 * Class DB
 * 
 * Application class for database connection
 */
class DB
{
    /**
    * Instance of the database connection 
    * @var \PDO
    */
    protected $connection;

    /**
    * Class constructor
    *
    * Attempts to instantiate a PDO connection to the database
    */
    public function __construct()
    {
        $config = (object) DATABASE;
        $dsn = "mysql:host=$config->host;dbname=$config->schema";
        try {
            $this->connection = new \PDO($dsn, $config->user, $config->password, $config->options);
        } catch (PDOException $e) {
            throw new \PDOException($e->getMessage(), (int)$e->getCode());
        }
    }

    /**
     * Executes a given SQL string
     * @param string $query
     * @return array
     */
    public function raw(string $query)
    {
        $results = $this->connection->query($query);
        return  $results->fetchAll();
    }
    /**
     * Retrives all data from a given table
     * @param string $table
     * @return array
     */
    public function getAllFromTable(string $table)
    {
        $sql = "SELECT * FROM $table";
        return self::get($sql);
    }

    /**
     * Retrives items from table given an id
     *
     * @param string $table
     * @param mixed $id
     * @return array
     */
    public function find(string $table, $id)
    {
        if (is_array($id)) {
            $id = implode(',', $id);
        }
        $sql = "SELECT * FROM $table WHERE id IN ($id)";
        return self::get($sql);
    }

    /**
     * processes given data and executes the query
     *  
     * @param string $sql
     * @param array|null $attributes
     * @return array
     */
    public function get(string $sql, array $attributes = null)
    {
        $db = $this->connection;
        if($attributes !== null){
            $query = $db->prepare($sql);
            $query->execute($attributes);
        }else {
                $query = $db->query($sql);
        }
            $results = $query->fetchAll();
            if(count($results) === 1){
                $results = $results[0];
            }
            return $results;

    }

    /**
     * Inserts new data into table
     *
     * @param string $table
     * @param array|null $attributes
     */
    public function put(string $table, array $attributes = null)
    {
        //TODO code this method
    }

    /**
     * Updates data into row
     *
     * @param string $table
     * @param string $id
     * @param array|null $attributes
     */
    public function update(string $table, string $id, array $attributes = null)
    {
        //TODO code this method
    }

}
