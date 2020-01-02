<?php


namespace Controllers;


use Core\Parents\Controller;
class DormitoryController extends Controller
{
    public function getAll() {
        $all = $this->model->getAll();
       $this->response($all,200);
    }
}