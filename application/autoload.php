<?php
/**
 *  Application autoload config file
 *
 */

spl_autoload_register('autoload');

/**
* Loads file if it exists
* @return void
*/
function autoload($class) {
    $file = ROOT.$class.'.php';
    if(file_exists($file)){
        include $file;
    }
}
