<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}Doctor.php"); //including Doctor Model


if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($doctor->validate_params($_POST['doctor_id'])){
        $doctor->Doctor_ID = $_POST['doctor_id'];
        $doctor->Doctor_Address = $_POST['doctor_address'];
        $doctor->Doctor_Contact = $_POST['doctor_contact'];
        $doctor->Doctor_Country = $_POST['doctor_country'];
        $doctor->Doctor_State = $_POST['doctor_state'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'ID is required!'));
        die();
    }
    if($doctor->validate_params($_POST['doctor_name'])){
        $doctor->Doctor_Name = $_POST['doctor_name'];
    }else{
        echo json_encode(array('success' => 0, "message" => 'Name is required!'));
        die();
    }

    $doctor_images_folder = "{$base_dir}assets{$ds}img{$ds}doctor{$ds}";

    if(!is_dir($doctor_images_folder)){
        mkdir($doctor_images_folder);
    }

    if(!isset($_FILES['images'])){
        if($doctor->update_doctor()){
            echo json_encode(array('success' => 1, "message" => 'Doctor Information Updated'));
        }else{
            http_response_code(500);
            echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
        }
    }else{
        $file_name = $_FILES['images']['name'];
        $file_tmp = $_FILES['images']['tmp_name'];
        $extension = end(explode('.', $file_name));

        $new_file_name = $doctor->Doctor_ID . "_profile.". "$extension";
        $location = "assets/img/doctor";
        move_uploaded_file($file_tmp, $doctor_images_folder . "/" . $new_file_name);

        $doctor->Doctor_Image = $location . "/" . $new_file_name;
        
        if($doctor->update_doctor()){
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