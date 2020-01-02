<?php

namespace Models;

use Core\DB;
use Core\Parents\Model;

class Dormitory extends Model
{
    protected $table = 'dormitories';

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