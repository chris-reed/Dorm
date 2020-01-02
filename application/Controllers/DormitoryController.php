<?php


namespace Controllers;


use Core\Parents\Controller;

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

}
