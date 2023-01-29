<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}Doctor.php"); //including Doctor Model

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($doctor->validate_params($_POST['doctor_id'])){
        $doctor->Doctor_ID = $_POST['doctor_id'];
    }else{
        echo json_encode(array("success" => 0, "message" => 'ID is required!', "doctor" => null, "patient" => null));
        die();
    }

    $p = $doctor->doctor_profile();
    if(gettype($p) === 'string'){
        http_response_code(402);
        echo json_encode(array("success" => 0, "message" => $p, "patient"=> null, "doctor"=> null));
    }else{
        http_response_code(402);
        echo json_encode(array("success" => 1, "message" => "Retrieve Success", "doctor"=> $p, "patient"=> null));
    }

}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}

?>