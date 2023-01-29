<?php

    $ds = DIRECTORY_SEPARATOR;
    $base_dir = realpath(dirname(__FILE__). $ds . '..') . $ds;

    require_once("{$base_dir}includes{$ds}Database.php"); //including Database

    class Doctor{
        private $table = 'doctors';

        public $Doctor_ID;
        public $Doctor_Name;
        public $Doctor_Email;
        public $Doctor_Address;
        public $Doctor_Contact;
        public $Doctor_Country;
        public $Doctor_State;
        public $Doctor_Password;
        public $Doctor_Image;
        public $Doctor_Specialization;

        public function __construct(){
            
        }

        public function validate_params($value){
            if(!empty($value)){
                return true;
            }else{
                return false;
            }
        }

        //Get Doctor List
        public function all_doctors(){
            global $database;
            if($database->escape_value($this->Doctor_Specialization) == "All"){
                $sql = "SELECT * FROM $this->table";
            }else{
                $sql = "SELECT * FROM $this->table WHERE doctor_department = '" . $database->escape_value($this->Doctor_Specialization) . "'";
            }
            $result = $database->query($sql);
            return $database->fetch_array($result);
        }

        public function update_doctor(){
            global $database;

            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));
            $this->Doctor_Name = trim(htmlspecialchars(strip_tags($this->Doctor_Name)));
            $this->Doctor_Email = trim(htmlspecialchars(strip_tags($this->Doctor_Email)));
            $this->Doctor_Address = trim(htmlspecialchars(strip_tags($this->Doctor_Address)));
            $this->Doctor_Contact = trim(htmlspecialchars(strip_tags($this->Doctor_Contact)));
            $this->Doctor_Country = trim(htmlspecialchars(strip_tags($this->Doctor_Country)));
            $this->Doctor_State = trim(htmlspecialchars(strip_tags($this->Doctor_State)));
            $this->Doctor_Image = trim(htmlspecialchars(strip_tags($this->Doctor_Image)));


            if($this->Doctor_Image == ""){
                $sql = "UPDATE $this->table SET 
                doctor_name = '" . $database->escape_value($this->Doctor_Name) . "', 
                doctor_address = '" . $database->escape_value($this->Doctor_Address) . "', 
                doctor_contact = '" . $database->escape_value($this->Doctor_Contact) . "',
                doctor_country = '" . $database->escape_value($this->Doctor_Country) . "', 
                doctor_state = '" . $database->escape_value($this->Doctor_State) . "' 
                WHERE doctor_id = '". $database->escape_value($this->Doctor_ID) ."'";
            }else{
                $sql = "UPDATE $this->table SET 
                doctor_name = '" . $database->escape_value($this->Doctor_Name) . "', 
                doctor_address = '" . $database->escape_value($this->Doctor_Address) . "', 
                doctor_contact = '" . $database->escape_value($this->Doctor_Contact) . "',
                doctor_country = '" . $database->escape_value($this->Doctor_Country) . "', 
                doctor_state = '" . $database->escape_value($this->Doctor_State) . "', 
                doctor_image = '" . $database->escape_value($this->Doctor_Image) . "'
                WHERE doctor_id = '". $database->escape_value($this->Doctor_ID) ."'";
            }

            $doctor_saves = $database->query($sql);

            if($doctor_saves){
                return true;
            }else{
                return false;
            }
        }

        public function doctor_profile(){
            global $database;

            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));

            $sql = "SELECT * FROM $this->table WHERE doctor_id = '". $database->escape_value($this->Doctor_ID) ."'";

            $result = $database->query($sql);
            $doctor = $database->fetch_row($result);

            if(empty($doctor)){
                return "Doctor doesn't exisit";
            }else{
                return $doctor;
            }
        }

    }

    $doctor = new Doctor();
?>