<?php

    $ds = DIRECTORY_SEPARATOR;
    $base_dir = realpath(dirname(__FILE__). $ds . '..') . $ds;

    require_once("{$base_dir}includes{$ds}Database.php"); //including Database

    class Feedback{
        private $table = 'feedbacks';

        public $Feedback_ID;
        public $Patient_ID;
        public $Doctor_ID;
        public $Rating;
        public $Remark;

        public function __construct(){
            
        }

        public function validate_params($value){
            if(!empty($value)){
                return true;
            }else{
                return false;
            }
        }

        public function add_feedback(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));
            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));
            $this->Remark = trim(htmlspecialchars(strip_tags($this->Remark)));;
            $this->Rating = trim(htmlspecialchars(strip_tags($this->Rating)));

            $sql = "INSERT INTO $this->table (patient_id, doctor_id, comment, rating) VALUES (
                '" . $database->escape_value($this->Patient_ID) . "', 
                '" . $database->escape_value($this->Doctor_ID) . "', 
                '" . $database->escape_value($this->Remark) . "', 
                '" . $database->escape_value($this->Rating) . "'
            )";

            $patient_saves = $database->query($sql);

            if($patient_saves){
                return true;
            }else{
                return false;
            }
        }

        public function feedback_status(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));
            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));

            $sql = "SELECT * FROM appointments WHERE 
            doctor_id = '". $database->escape_value($this->Doctor_ID) ."' AND
            patient_id = '". $database->escape_value($this->Patient_ID) ."'";

            $result_feedback = $database->query($sql);
            $result = $database->fetch_row($result_feedback);

            if(empty($result)){
                return false;
            }else{
                return true; 
            }

        }

        public function get_feedback(){
            global $database;
            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));

            $sql = "SELECT $this->table.patient_id as patient_id, $this->table.doctor_id as doctor_id, feedback_id, patient_name, patient_image, doctor_name, doctor_image, rating, comment FROM $this->table, patients, doctors WHERE 
            $this->table.doctor_id = '". $database->escape_value($this->Doctor_ID) ."'
            AND $this->table.doctor_id = doctors.doctor_id AND $this->table.patient_id = patients.patient_id";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        
        }

        public function get_patient_feedback(){
            global $database;
            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));

            $sql = "SELECT $this->table.patient_id as patient_id, $this->table.doctor_id as doctor_id, feedback_id, patient_name, patient_image, doctor_name, doctor_image, rating, comment FROM $this->table, patients, doctors WHERE 
            $this->table.patient_id = '". $database->escape_value($this->Patient_ID) ."'
            AND $this->table.doctor_id = doctors.doctor_id AND $this->table.patient_id = patients.patient_id";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        
        }

    }

    $feedback  = new Feedback();
?>