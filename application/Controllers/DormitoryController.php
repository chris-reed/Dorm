<?php


namespace Controllers;


use Core\Parents\Controller;
use Models\RoomAssignment;

/**
* DormitoryController Class
*
*/
class DormitoryController extends Controller
{

    public function getAll() {
        $building = $this->model->getAll();
        $this->response($building);
    }

    public function getAvailableRooms() {
        $results = [];
        $assignments = new RoomAssignment();
       $dorms = $this->model->getAll();
       foreach ($dorms as  $dorm){
           $dorm = (object) $dorm;
           for($units = 1; $units <= $dorm->total_units; $units++){
               $available = $assignments->available_rooms($dorm->id,$units);
               if(count($available) > 0){
                   $results[$dorm->id] = [
                       'name' => $dorm->name,
                       'unit' => [
                           'id' => $units,]
                       ,
                   ];
                   $results[$dorm->id][$units]['rooms'][] = $available;
               }
           }
       }
       $this->response($results);
    }
}
