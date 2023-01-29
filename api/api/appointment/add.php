<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}Appointment.php"); //including Doctor Model


if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($appointment->validate_params($_POST['doctor_id'])){
        $appointment->Doctor_ID = $_POST['doctor_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Doctor_ID is required!'));
        die();
    }
    if($appointment->validate_params($_POST['patient_id'])){
        $appointment->Patient_ID = $_POST['patient_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Patient_ID is required!'));
        die();
    }
    if($appointment->validate_params($_POST['date'])){
        $appointment->Appointment_Date = $_POST['date'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Appointment Date is required!'));
        die();
    }
    if($appointment->validate_params($_POST['mode'])){
        $appointment->Appointment_Location = $_POST['mode'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Appointment Location is required!'));
        die();
    }
    if($appointment->validate_params($_POST['slot'])){
        $appointment->Appointment_Slot = $_POST['slot'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Appointment Slot is required!'));
        die();
    }
    
    if($appointment->add_appointment()){
        echo json_encode(array('success' => 1, "message" => 'Appointment Successfully Registered'));
    }else{
        http_response_code(500);
        echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
    }
   
}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}
?>