<?php


namespace Controllers;

use Core\Parents\Controller;
use Models\RoomAssignment;

class StudentController extends Controller
{

    public function getOccupancyInfo() {
        $data = (object) $this->request->get('data');
        $stub = [
            'first_name' => 'Available',
            'last_name' => 'Space',
            'phone' => 'click to add student',
            'student_id' =>'',
        ];

        $location = $data->location;
        $occupants = (new RoomAssignment())->occupants($location[0],$location[1],$location[2]);
        if(array_key_exists('student_id',$occupants)){
            $occupants = [$occupants,$stub];
        }
        if(empty($occupants)){
            $occupants = [$stub,$stub];
        }
        $this->response($occupants);
    }
}