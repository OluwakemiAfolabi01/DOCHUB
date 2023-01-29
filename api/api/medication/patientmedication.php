<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');


$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;


require_once("{$base_dir}models{$ds}Medication.php"); //including Patient Model

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($medication->validate_params($_POST['patient_id'])){
        $medication->Patient_ID = $_POST['patient_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Patient ID is required!'));
        die();
    }
    echo json_encode(array('success' => 1, 'medication'=> $medication->get_patient_medication()));
}else{
    die(header('HTTP/1.1 405 Request Method Not Allowed!'));
}

?>