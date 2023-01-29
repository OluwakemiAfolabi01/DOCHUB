<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow.Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' . $ds . '..') . $ds;

require_once("{$base_dir}models{$ds}User.php"); 

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    if($user->validate_params($_POST['email'])){
        $user->User_Email = $_POST['email'];
        $userType = $_POST['user'];
        $user->User_Token = $_POST['token'];
    }else{
        echo json_encode(array("success" => 0, "message" => 'Email is required!'));
        die();
    }
    if($user->update_token($userType)){
        echo json_encode(array('success' => 1, "message" => 'Token Saved'));
    }else{
        http_response_code(500);
        echo json_encode(array('success' => 0, "message" => 'Internal Server Error!'));
    }

}else{
    die(header('HTTP/1.1 405 Request Method Not Allows'));
}

?>