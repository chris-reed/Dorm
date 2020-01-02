<?php

namespace Models;

use Core\DB;
use Core\Parents\Model;

/**
* Class Dormatory
*
* Model for the dormatories table
*/
class Dormitory extends Model
{
    /**
    * Table associated with this Model
    * @var string
    */
    protected $table = 'dormitories';

    /**
    * Gets unit and room information for a givel floor in a given building
    *
    * @param int $floor 
    * @param int $dorm
    *
    * @return object
    */
    public function floor($dorm, $floor = 1){
        $assignments = new RoomAssignment();
        $units = [1,2,3,4];
        $results = [];
        array_walk($units, function(&$value, $key)use($floor) { $value += (4*($floor-1)); } );
        foreach ($units as $unit){
            for ($room = 1; $room <=4; $room++){
                $results[$unit][$room] = count($assignments->occupants($dorm,$unit,$room));
            }
            $results[$unit]['gender'] = strtolower($assignments->unit_gender($dorm,$unit));

        }
        return (object) $results;
    }
}
