<?php
spl_autoload_register('autoload');
function autoload($class) {
    $file = ROOT.$class.'.php';
    if(file_exists($file)){
        include $file;
    }
}