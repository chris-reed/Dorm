<?php

namespace Models;

use Core\Parents\Model;
use RuntimeException;

/**
* Class RoomAssignment
*
* Model for the room_assignments table
*/
class RoomAssignment extends Model
{

    /**
    * Table associated with this Model
    * @var string
    */
    protected $table = 'room_assignments';

    /**
     * Returns the gender requirement for a given unit.
     *
     * @param  int $building
     * @param int $unit
     * @return string
     */
    public function unit_gender($building, $unit) {
        $sql = "SELECT * FROM room_assignments WHERE dormitory_id= $building AND unit= $unit";
        $student_ids =  $this->db->get($sql);
        if(isset($student_ids['id'])){
           $student  = (object) (new Student())->find($student_ids['student_id']);
           return $student->gender;
        }
        $students = (new Student())->find($this->pluck('student_id',$student_ids));
        $gender = array_unique($this->pluck('gender',$students));
        if(count($gender) > 1){
            throw new RuntimeException('Only one gender allowed in unit ');
        }
        return $gender[0];
    }

    /**
     * Returns the room numbers of a given unit where there is space available 
     *
     * @param int $building
     * @param int $unit
     * @return array
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
    /**
     * Returns the student information of all students in a building/unit/room 
     *
     * @param int $building
     * @param int $unit
     * @param int $room
     * @return array
     */
    public function occupants($building,$unit=null,$room=null){
        $sql = "SELECT student_id FROM room_assignments WHERE dormitory_id=$building ";
        if($unit){
            $sql .= "AND unit=$unit ";
            if($room){
                $sql .= "AND room=$room ";
            }
        }
        $occupants = $this->db->raw($sql);
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
