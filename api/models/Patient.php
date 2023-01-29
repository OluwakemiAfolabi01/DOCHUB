<?php

    $ds = DIRECTORY_SEPARATOR;
    $base_dir = realpath(dirname(__FILE__). $ds . '..') . $ds;

    require_once("{$base_dir}includes{$ds}Database.php"); //including Database

    class Patient{
        private $table = 'patients';

        public $Patient_ID;
        public $Patient_Name;
        public $Patient_Email;
        public $Patient_Address;
        public $Patient_Contact;
        public $Patient_Country;
        public $Patient_State;
        public $Patient_Password;
        public $Patient_Image;
        public $Patient_Height;
        public $Patient_Weight;

        public function __construct(){
            
        }

        public function validate_params($value){
            if(!empty($value)){
                return true;
            }else{
                return false;
            }
        }

        //Check Email Unique
        public function check_unique_email(){
            global $database;

            $this->Patient_Email = trim(htmlspecialchars_decode(strip_tags($this->Patient_Email)));

            $sql = "SELECT patient_id from $this->table WHERE patient_email = '". $database->escape_value($this->Patient_Email)  ."'";

            $result = $database->query($sql);
            
            $patient_id = $database->fetch_row($result);

            if(empty($patient_id)){
                return true;
            }else{
                return false;
            }
        }

        public function register_patient(){
            global $database;

            // $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));
            $this->Patient_Name = trim(htmlspecialchars(strip_tags($this->Patient_Name)));
            $this->Patient_Email = trim(htmlspecialchars(strip_tags($this->Patient_Email)));
            $this->Patient_Address = trim(htmlspecialchars(strip_tags($this->Patient_Address)));
            $this->Patient_Contact = trim(htmlspecialchars(strip_tags($this->Patient_Contact)));
            $this->Patient_Country = trim(htmlspecialchars(strip_tags($this->Patient_Country)));
            $this->Patient_State = trim(htmlspecialchars(strip_tags($this->Patient_State)));
            $this->Patient_Password = trim(htmlspecialchars(strip_tags(md5($this->Patient_Password))));
            $this->Patient_Image = trim(htmlspecialchars(strip_tags("assets/img/patient/default.png")));
            
            $sql = "INSERT INTO $this->table (patient_name, patient_email, patient_contact, patient_image, patient_password) VALUES (
                '" . $database->escape_value($this->Patient_Name) . "', 
                '" . $database->escape_value($this->Patient_Email) . "',  
                '" . $database->escape_value($this->Patient_Contact) . "',
                '" . $database->escape_value($this->Patient_Image) . "', 
                '" . $database->escape_value($this->Patient_Password) . "'
            )";

            $patient_saves = $database->query($sql);

            if($patient_saves){
                return true;
            }else{
                return false;
            }
        }

        public function update_patient(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));
            $this->Patient_Name = trim(htmlspecialchars(strip_tags($this->Patient_Name)));
            $this->Patient_Address = trim(htmlspecialchars(strip_tags($this->Patient_Address)));
            $this->Patient_Contact = trim(htmlspecialchars(strip_tags($this->Patient_Contact)));
            $this->Patient_Country = trim(htmlspecialchars(strip_tags($this->Patient_Country)));
            $this->Patient_State = trim(htmlspecialchars(strip_tags($this->Patient_State)));
            $this->Patient_Image = trim(htmlspecialchars(strip_tags($this->Patient_Image)));
            $this->Patient_Height = trim(htmlspecialchars(strip_tags($this->Patient_Height)));
            $this->Patient_Weight = trim(htmlspecialchars(strip_tags($this->Patient_Weight)));

            if($this->Patient_Image == ""){
                $sql = "UPDATE $this->table SET 
                patient_name = '" . $database->escape_value($this->Patient_Name) . "', 
                patient_address = '" . $database->escape_value($this->Patient_Address) . "',
                patient_contact = '" . $database->escape_value($this->Patient_Contact) . "',  
                patient_country = '" . $database->escape_value($this->Patient_Country) . "', 
                patient_state = '" . $database->escape_value($this->Patient_State) . "',
                height = '" . $database->escape_value($this->Patient_Height) . "', 
                weight = '" . $database->escape_value($this->Patient_Weight) . "'
                WHERE patient_id = '". $database->escape_value($this->Patient_ID) ."'";
            }else{
                $sql = "UPDATE $this->table SET 
                patient_name = '" . $database->escape_value($this->Patient_Name) . "', 
                patient_address = '" . $database->escape_value($this->Patient_Address) . "',
                patient_contact = '" . $database->escape_value($this->Patient_Contact) . "',  
                patient_country = '" . $database->escape_value($this->Patient_Country) . "', 
                patient_state = '" . $database->escape_value($this->Patient_State) . "',
                patient_image = '" . $database->escape_value($this->Patient_Image) . "',
                height = '" . $database->escape_value($this->Patient_Height) . "', 
                weight = '" . $database->escape_value($this->Patient_Weight) . "'
                WHERE patient_id = '". $database->escape_value($this->Patient_ID) ."'";
            }
            

            $patient_saves = $database->query($sql);

            if($patient_saves){
                return true;
            }else{
                return false;
            }
        }

        public function patient_profile(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));

            $sql = "SELECT * FROM $this->table WHERE patient_id = '". $database->escape_value($this->Patient_ID) ."'";

            $result = $database->query($sql);
            $patient = $database->fetch_row($result);

            if(empty($patient)){
                return "Patient doesn't exisit";
            }else{
                return $patient;
            }
        }
    }

    $patient = new Patient();
?>