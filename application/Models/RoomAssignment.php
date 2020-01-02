<?php

namespace Models;

use Core\DB;
use Core\Parents\Model;

class RoomAssignment extends Model
{

    protected $table = 'room_assignments';

    /**
     * @param $building
     * @param $unit
     * @return mixed
     * @throws Exception
     */
    public function unit_gender($building, $unit) {
        $sql = "SELECT student_id FROM room_assignments WHERE dormitory_id= :dorm AND unit= :unit";
        $student_ids =  $this->db->get($sql,[
            'dorm' => $building,
            'unit' => $unit,
        ]);
        $students = (new Student())->find($this->pluck('student_id',$student_ids));
        $gender = array_unique($this->pluck('gender',$students));
        if(count($gender) > 1){
            throw new RuntimeException('Only one gender allowed in unit ');
        }
        return $gender[0];
    }

    /**
     * @param $building
     * @param $unit
     * @return array
     * @throws Exception
     */
    public function available_rooms($building,$unit) {
        $available = [];
        for($room = 1;$room <= 4; $room++){
            $students = count(self::occupants($building,$unit,$room));
            if($students < 2){
                $available[] = $room;
            }
        }
        return $available;
    }
    public function occupants($building,$unit=null,$room=null){
        $sql = "SELECT student_id FROM room_assignments WHERE dormitory_id=$building ";
        if($unit){
            $sql .= "AND unit=$unit ";
            if($room){
                $sql .= "AND room=$room ";
            }
        }
        $occupants = $this->db->get(trim($sql));
        if(isset($occupants['student_id'])) {
            $occupants =  [$occupants];
        }
        if(empty($occupants)) {
            return [];
        }
        $occupants = $this->pluck('student_id',$occupants);
        return (new Student())->find($occupants);
    }



}