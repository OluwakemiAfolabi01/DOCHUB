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
        $patient->Patient_Address = $_POST['patient_address'];
        $patient->Patient_Contact = $_POST['patient_contact'];
        $patient->Patient_Country = $_POST['patient_country'];
        $patient->Patient_State = $_POST['patient_state'];
        $patient->Patient_Height = $_POST['patient_height'];
        $patient->Patient_Weight = $_POST['patient_weight'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Patient ID is required!'));
        die();
    }
    if($patient->validate_params($_POST['patient_name'])){
        $patient->Patient_Name = $_POST['patient_name'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Name is required!'));
        die();
    }
    
    $patient_images_folder = "{$base_dir}assets{$ds}img{$ds}patient{$ds}";
    if(!is_dir($patient_images_folder)){
        mkdir($patient_images_folder);
    }

    if(!isset($_FILES['images'])){
        if($patient->update_patient()){
            echo json_encode(array('success' => 1, "message" => 'Patient Information Updated'));
        }else{
            http_response_code(500);
            echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
        }
    }else{
        $file_name = $_FILES['images']['name'];
        $file_tmp = $_FILES['images']['tmp_name'];
        $extension = end(explode('.', $file_name));

        $new_file_name = $patient->Patient_ID . "_profile.". "$extension";
        $location = "assets/img/patient";
        move_uploaded_file($file_tmp, $patient_images_folder . "/" . $new_file_name);

        $patient->Patient_Image = $location . "/" . $new_file_name;
        
        if($patient->update_patient()){
            echo json_encode(array('success' => 1, "message" => 'Patient Information Updated'));
        }else{
            http_response_code(500);
            echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
        }
    }
}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}
?>
