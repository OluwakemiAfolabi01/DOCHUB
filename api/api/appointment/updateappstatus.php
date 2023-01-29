<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}Appointment.php"); //including Doctor Model

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($appointment->validate_params($_POST['patient_id'])){
        $appointment->Patient_ID = $_POST['patient_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Patient ID is required!'));
        die();
    }
    if($appointment->validate_params($_POST['doctor_id'])){
        $appointment->Doctor_ID = $_POST['doctor_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Doctor ID is required!'));
        die();
    }
    if($appointment->validate_params($_POST['mode'])){
        $appointment->Appointment_Location = $_POST['mode'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Appointment Location is required!'));
        die();
    }
    if($appointment->validate_params($_POST['status'])){
        $appointment->Appointment_Status = $_POST['status'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Appointment Status is required!'));
        die();
    }

    
    if($appointment->update_appointment_status()){
        echo json_encode(array('success' => 1, "message" => 'Appointment Successfully Updated'));
    }else{
        http_response_code(500);
        echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
    }
   
}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}
?>