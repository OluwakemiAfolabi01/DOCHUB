<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}Patient.php"); //including Patient Model

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($patient->validate_params($_POST['patient_id'])){
        $patient->Patient_ID = $_POST['patient_id'];
    }else{
        echo json_encode(array("success" => 0, "message" => 'ID is required!', "patient" => null, "doctor" => null));
        die();
    }

    $p = $patient->patient_profile();
    if(gettype($p) === 'string'){
        http_response_code(402);
        echo json_encode(array("success" => 0, "message" => $p, "patient"=> null, "doctor"=> null));
    }else{
        http_response_code(402);
        echo json_encode(array("success" => 1, "message" => "Success", "patient"=> $p, "doctor"=> null));
    }

}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}

?>