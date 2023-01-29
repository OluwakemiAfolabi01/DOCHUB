<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}Medication.php"); //including Doctor Model


if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($medication->validate_params($_POST['doctor_id'])){
        $medication->Doctor_ID = $_POST['doctor_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Doctor_ID is required!'));
        die();
    }
    if($medication->validate_params($_POST['patient_id'])){
        $medication->Patient_ID = $_POST['patient_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Patient_ID is required!'));
        die();
    }
    if($medication->validate_params($_POST['file'])){
        $medication->Document = $_POST['file'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'File is required!'));
        die();
    }
    if($medication->add_medical()){
        echo json_encode(array('success' => 1, "message" => 'Medication Uploaded'));
    }else{
        http_response_code(500);
        echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
    }
   
}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}
?>