<?php

    $ds = DIRECTORY_SEPARATOR;
    $base_dir = realpath(dirname(__FILE__). $ds . '..') . $ds;

    require_once("{$base_dir}includes{$ds}Database.php"); //including Database

    class Medical{
        private $table = 'medications';

        public $Record_ID;
        public $Date_Created;
        public $Document;
        public $Patient_ID;
        public $Doctor_ID;

        public function __construct(){
            
        }

        public function validate_params($value){
            if(!empty($value)){
                return true;
            }else{
                return false;
            }
        }

        public function add_medical(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));
            $this->Date_Created = trim(htmlspecialchars(strip_tags($this->Date_Created)));
            $this->Document = trim(htmlspecialchars(strip_tags($this->Document)));;

            
            $sql = "INSERT INTO $this->table (patient_id, doctor_id, date, file) VALUES (
                '" . $database->escape_value($this->Patient_ID) . "', 
                '" . $database->escape_value($this->Doctor_ID) . "', 
                '" . $database->escape_value(Date('Y-m-d')) . "', 
                '" . $database->escape_value($this->Document) . "' 
            )";

            $medication_saves = $database->query($sql);

            if($medication_saves){
                return true;
            }else{
                return false;
            }
        }

        public function get_patient_medication(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));

            $sql = "SELECT medication_id, medications.patient_id as patient_id, medications.doctor_id as doctor_id, doctor_department, date, patient_name, doctor_name,  doctor_image, patient_image, file FROM $this->table, patients, doctors WHERE 
            $this->table.patient_id = '". $database->escape_value($this->Patient_ID) ."'
            AND $this->table.Doctor_ID = doctors.Doctor_ID AND $this->table.Patient_ID = patients.Patient_ID ORDER BY date";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        }

    }

    $medication = new Medical();
?>