<?php

namespace Models;

use Core\Parents\Model;

class Student extends Model
{
    protected $table = 'students';

    public static function gender($id){
        $student = self::find($id);
        return pluck('gender', $student,'first');
    }
    /**
     * @param $id
     * @return array
     * @throws Exception
     */
    public static function assigned_room($id) {
            $sql = "SELECT * FROM room_assignments WHERE student_id=$id";
            return DB::get($sql);
        }
}