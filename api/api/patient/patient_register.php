<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}Patient.php"); //including Patient Model


if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($patient->validate_params($_POST['patient_name'])){
        $patient->Patient_Name = $_POST['patient_name'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Name is required!'));
        die();
    }
    if($patient->validate_params($_POST['patient_email'])){
        $patient->Patient_Email = $_POST['patient_email'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Email is required!'));
        die();
    }
    if($patient->validate_params($_POST['patient_contact'])){
        $patient->Patient_Contact = $_POST['patient_contact'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Contact is required!'));
        die();
    }
    if($patient->validate_params($_POST['patient_password'])){
        $patient->Patient_Password = $_POST['patient_password'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Password is required!'));
        die();
    }

    if($patient->check_unique_email()){
        if($patient_ID = $patient->register_patient()){
            echo json_encode(array('success' => 1, "message" => 'Patient Successfully Registered'));
        }else{
            http_response_code(500);
            echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
        }
    }else{
        http_response_code(401);
        echo json_encode(array('success' => 0, "message" => 'Email Already Exist!'));
    }


}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}
?>