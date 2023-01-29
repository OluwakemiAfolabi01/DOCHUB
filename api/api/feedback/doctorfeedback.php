<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');


$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;


require_once("{$base_dir}models{$ds}Feedback.php"); //including Patient Model

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($feedback->validate_params($_POST['doctor_id'])){
        $feedback->Doctor_ID = $_POST['doctor_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Doctor ID is required!'));
        die();
    }
    echo json_encode(array('success' => 1, 'feedbacks'=> $feedback->get_feedback()));
}else{
    die(header('HTTP/1.1 405 Request Method Not Allowed!'));
}

?>