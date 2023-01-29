<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}User.php"); //including Doctor Model

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($user->validate_params($_POST['user_email'])){
        $user->User_Email = $_POST['user_email'];
    }else{
        echo json_encode(array("success" => 0, "message" => 'Email is required!', "doctor" => null, "patient" => null));
        die();
    }
    if($user->validate_params($_POST['user_password'])){
        $user->User_Password = $_POST['user_password'];
    }else{
        echo json_encode(array("success" => 0, "message" => 'Password is required!', "doctor" => null, "patient" => null));
        die();
    }

    $d = $user->login_user();
    if(gettype($d) === 'string'){
        http_response_code(402);
        echo json_encode(array("success" => 0, "message" => $d, "doctor" => null, "patient" => null));
    }else{
        http_response_code(402);
        if($d["type"] == "patient"){
            echo json_encode(array("success" => 1, "message" => "Login Successful", "doctor"=> null, "patient" => $d["user"]));
        }else if($d["type"] == "doctor"){
            echo json_encode(array("success" => 1, "message" => "Login Successful", "doctor"=> $d["user"], "patient" => null));
        }
        
    }

}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}

?>