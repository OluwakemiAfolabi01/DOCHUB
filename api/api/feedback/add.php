<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}Feedback.php"); //including Doctor Model


if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($feedback->validate_params($_POST['doctor_id'])){
        $feedback->Doctor_ID = $_POST['doctor_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Doctor_ID is required!'));
        die();
    }
    if($feedback->validate_params($_POST['patient_id'])){
        $feedback->Patient_ID = $_POST['patient_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Patient_ID is required!'));
        die();
    }
    if($feedback->validate_params($_POST['rating'])){
        $feedback->Rating = $_POST['rating'];
        $feedback->Remark = $_POST['comment'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Rating is required!'));
        die();
    }
    if($feedback->add_feedback()){
        echo json_encode(array('success' => 1, "message" => 'Feedback Successfully Updated'));
    }else{
        http_response_code(500);
        echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
    }
   
}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}
?>