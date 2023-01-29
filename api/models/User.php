<?php

    $ds = DIRECTORY_SEPARATOR;
    $base_dir = realpath(dirname(__FILE__). $ds . '..') . $ds;

    require_once("{$base_dir}includes{$ds}Database.php"); //including Database

    class User{
        private $doctor_table = 'doctors';
        private $patient_table = 'patients';

        public $User_Email;
        public $User_Password;
        public $User_Token;

        public function __construct(){
            
        }

        public function validate_params($value){
            if(!empty($value)){
                return true;
            }else{
                return false;
            }
        }

        
        //Doctor Login
        public function login_user(){
            global $database;

            $this->User_Email = trim(htmlspecialchars(strip_tags($this->User_Email)));
            $this->User_Password = trim(htmlspecialchars(strip_tags(md5($this->User_Password))));

            $sql_patient = "SELECT * FROM $this->patient_table WHERE patient_email = '". $database->escape_value($this->User_Email) ."'";
            $sql_doctor = "SELECT * FROM $this->doctor_table WHERE doctor_email = '". $database->escape_value($this->User_Email) ."'";
            $result_patient = $database->query($sql_patient);
            $result_doctor = $database->query($sql_doctor);
            $patient = $database->fetch_row($result_patient);
            $doctor = $database->fetch_row($result_doctor);
            if(empty($patient)){
                if(empty($doctor)){
                    return "User does not exist";
                }else{
                    return array("type" => "doctor", "user"=> $doctor); 
                }
            }else{
                return array("type" => "patient", "user"=> $patient); 
            }
        }

        public function update_token($userType){
            global $database;

            if ($userType == "doctor"){
                $sql = "UPDATE $this->doctor_table SET userToken = '" . $database->escape_value($this->User_Token) . "' 
                WHERE doctor_email = '" . $database->escape_value($this->User_Email) ."'";
                
            } else if ($userType == "patient") {
                $sql = "UPDATE $this->patient_table SET userToken = '" . $database->escape_value($this->User_Token) . "' 
                WHERE patient_email = '" . $database->escape_value($this->User_Email) ."'";
            }

            $token_saves = $database->query($sql);

            if($token_saves){
                return true;
            }else{
                return false;
            }
        }
    }

    $user = new User();
?>