<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');


$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;


require_once("{$base_dir}models{$ds}Appointment.php"); //including Patient Model

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($appointment->validate_params($_POST['patient_id'])){
        $appointment->Patient_ID = $_POST['patient_id'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Patient ID is required!'));
        die();
    }
    if($appointment->validate_params($_POST['date'])){
        $appointment->Appointment_Date = $_POST['date'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Appointment Date is required!'));
        die();
    }

    echo json_encode(array('success' => 1, 'appointments'=> $appointment->get_prevpatientapp()));
}else{
    die(header('HTTP/1.1 405 Request Method Not Allowed!'));
}

?>