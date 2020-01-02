<?php

namespace Core;
/**
 * Class DB
 * application class for PDO
 */
class DB
{
    protected $connection;

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
     * @param string $query
     * @return array
     * @throws Exception
     */
    public function raw(string $query)
    {
        return self::get($query);
    }

    /**
     * @param string $table
     * @return array
     * @throws Exception
     */
    public function getAllFromTable(string $table)
    {
        $sql = "SELECT * FROM $table";
        return self::get($sql);
    }

    /**
     * @param string $table
     * @param $id
     * @return array
     * @throws Exception
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
     * @param string $sql
     * @param array|null $attributes
     * @return array
     * @throws Exception
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
     * @param string $table
     * @param array|null $attributes
     */
    public function put(string $table, array $attributes = null)
    {
        //TODO
    }

    /**
     * updates data into row
     * @param string $table
     * @param string $id
     * @param array|null $attributes
     */
    public function update(string $table, string $id, array $attributes = null)
    {
        //TODO
    }

}