<?php


namespace Controllers;


use Cassandra\Cluster\Builder;
use Core\Parents\Controller;
use Models\Dormitory;

/**
* RoomAssignmentController Class
*
*/
class RoomAssignmentController extends Controller
{
    /**
    * Gets room occupancy and unit gender requirement info for all units on a given floor
    *
    */
    public function getFloorInfo() {
        $data = (object) $this->request->get('data');
        $dorm = (object) (new Dormitory())->find($data->dorm);
        $data->floor = (int) $data->floor;
        $total_floors = (int) $dorm->total_units / $dorm->units_per_floor;
        $floor = $data->floor - 1;
        for($x =1; $x <= $dorm->units_per_floor;$x++){
            $units[] = $x+($total_floors*$floor);
        }
        $results = [];
        foreach ($units as $unit){
            for ($room = 1; $room <=4; $room++){
                $occupants = $this->model->occupants($dorm->id,$unit,$room);
                $results[$unit][$room] = 1;
                if(!array_key_exists('id',$occupants)){
                    $results[$unit][$room] = count($occupants);
                }
            }
            $results[$unit]['gender'] = strtolower($this->model->unit_gender($dorm->id,$unit));
        }
        $this->response($results);
    }

}
