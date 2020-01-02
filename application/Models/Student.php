<?php

namespace Models;

use Core\Parents\Model;

/**
* Class Student
*
* Model for the students table
*/
class Student extends Model
{
    /**
    * Table associated with this Model
    * @var string
    */
    protected $table = 'students';

    /**
     * Returns the gender of a given student 
     *
     * @param int $id
     * @return string
     * @throws Exception
     */
    public static function gender($id){
        $student = self::find($id);
        return pluck('gender', $student,'first');
    }

    /**
     * Returns the assigned room of a given student 
     *
     * @param int $id
     * @return string
     * @throws Exception
     */
    public static function assigned_room($id) {
            $sql = "SELECT * FROM room_assignments WHERE student_id=$id";
            return DB::get($sql);
        }
}
