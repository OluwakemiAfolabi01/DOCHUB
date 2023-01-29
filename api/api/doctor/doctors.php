<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');


$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;


require_once("{$base_dir}models{$ds}Doctor.php"); //including Patient Model

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($doctor->validate_params($_POST['department'])){
        $doctor->Doctor_Specialization = $_POST['department'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Name is required!'));
        die();
    }
    echo json_encode(array('success' => 1, 'doctors'=> $doctor->all_doctors()));
}else{
    die(header('HTTP/1.1 405 Request Method Not Allowed!'));
}

?>