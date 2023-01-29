<?php

    $ds = DIRECTORY_SEPARATOR;
    $base_dir = realpath(dirname(__FILE__). $ds . '..') . $ds;

    require_once("{$base_dir}includes{$ds}Database.php"); //including Database

    class Appointment{
        private $table = 'appointments';

        public $Appointment_ID;
        public $Patient_ID;
        public $Doctor_ID;
        public $Appointment_Date;
        public $Appointment_Location;
        public $Appointment_Slot;
        public $Appointment_Status;

        public function __construct(){
            
        }

        public function validate_params($value){
            if(!empty($value)){
                return true;
            }else{
                return false;
            }
        }

        public function add_appointment(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));
            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));
            $this->Appointment_Date = trim(htmlspecialchars(strip_tags($this->Appointment_Date)));;
            $this->Appointment_Location = trim(htmlspecialchars(strip_tags($this->Appointment_Location)));
            $this->Appointment_Slot = trim(htmlspecialchars(strip_tags($this->Appointment_Slot)));

            
            $sql = "INSERT INTO $this->table (patient_id, doctor_id, date, mode, slot) VALUES (
                '" . $database->escape_value($this->Patient_ID) . "', 
                '" . $database->escape_value($this->Doctor_ID) . "', 
                '" . $database->escape_value($this->Appointment_Date) . "', 
                '" . $database->escape_value($this->Appointment_Location) . "', 
                '" . $database->escape_value($this->Appointment_Slot) . "'
            )";

            $patient_saves = $database->query($sql);

            if($patient_saves){
                return true;
            }else{
                return false;
            }
        }

        public function get_patientapp(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));

            $sql = "SELECT appointment_id, appointments.patient_id as patient_id, appointments.doctor_id as doctor_id, doctor_department, patient_name, slot, date, mode, patient_name, patient_contact, doctor_contact, doctor_name, doctor_image, patient_image FROM $this->table, patients, doctors WHERE 
            $this->table.patient_id = '". $database->escape_value($this->Patient_ID) ."'
            AND $this->table.Doctor_ID = doctors.Doctor_ID AND $this->table.Patient_ID = patients.Patient_ID ORDER BY date";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        }

        public function get_doctorapp(){
            global $database;

            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));

            $sql = "SELECT appointment_id, appointments.patient_id as patient_id, appointments.doctor_id as doctor_id, doctor_department, patient_name, slot, date, mode, patient_name, patient_contact, doctor_contact, doctor_name, doctor_image, patient_image FROM $this->table, patients, doctors WHERE 
            $this->table.doctor_id = '". $database->escape_value($this->Doctor_ID) ."'
            AND $this->table.Doctor_ID = doctors.Doctor_ID AND $this->table.Patient_ID = patients.Patient_ID ORDER BY date";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        }

        public function get_prevpatientapp(){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));
            $this->Appointment_Date = trim(htmlspecialchars(strip_tags($this->Appointment_Date)));;

            $sql = "SELECT appointment_id, appointments.patient_id as patient_id, appointments.doctor_id as doctor_id, doctor_department, patient_name, slot, date, mode, patient_name, patient_contact, doctor_name, doctor_image FROM $this->table, patients, doctors WHERE 
            $this->table.patient_id = '". $database->escape_value($this->Patient_ID) ."' AND
            date < '". $database->escape_value($this->Appointment_Date) ."'
            AND $this->table.Doctor_ID = doctors.Doctor_ID AND $this->table.Patient_ID = patients.Patient_ID ORDER BY date";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        }

        public function update_appointment(){
            global $database;

            $this->Appointment_ID = trim(htmlspecialchars(strip_tags($this->Appointment_ID)));
            $this->Appointment_Date = trim(htmlspecialchars(strip_tags($this->Appointment_Date)));;
            $this->Appointment_Location = trim(htmlspecialchars(strip_tags($this->Appointment_Location)));
            $this->Appointment_Slot = trim(htmlspecialchars(strip_tags($this->Appointment_Slot)));

            
            $sql = "UPDATE $this->table SET  
            `date` = '" . $database->escape_value($this->Appointment_Date) . "', 
            `mode` = '" . $database->escape_value($this->Appointment_Location) . "',
            `slot` = '" . $database->escape_value($this->Appointment_Slot) . "'
            WHERE `appointment_id` = '". $database->escape_value($this->Appointment_ID) ."'";
            

            $appointment_saves = $database->query($sql);

            if($appointment_saves){
                return true;
            }else{
                return false;
            }
        }

        public function delete_appointment(){
            global $database;

            $this->Appointment_ID = trim(htmlspecialchars(strip_tags($this->Appointment_ID)));

            $sql = "DELETE FROM $this->table WHERE appointment_id = '". $database->escape_value($this->Appointment_ID) ."'";

            $appointment_saves = $database->query($sql);

            if($appointment_saves){
                return true;
            }else{
                return false;
            }
        }

        public function get_mydoctor($department){
            global $database;

            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));

            if ($department == "All" || $department == ""){
                $sql = "SELECT DISTINCT doctors.doctor_id, doctor_name, doctor_email, doctor_contact, doctor_country, doctor_state, doctor_address, doctor_department, doctor_experience, doctor_image, doctors.userToken as userToken FROM $this->table, patients, doctors WHERE 
                $this->table.patient_id = '". $database->escape_value($this->Patient_ID) ."'
                AND date <= '" . date("Y-m-d") . "'
                AND $this->table.doctor_id = doctors.doctor_id AND $this->table.patient_id = patients.patient_id";

            }else{
                $sql = "SELECT DISTINCT doctors.doctor_id, doctor_name, doctor_email, doctor_contact, doctor_country, doctor_state, doctor_address, doctor_department, doctor_experience, doctor_image FROM $this->table, patients, doctors WHERE 
                $this->table.patient_id = '". $database->escape_value($this->Patient_ID) ."'
                AND doctor_department = '" . $database->escape_value($department) . "'
                AND date <= '" . date("Y-m-d") . "'
                AND $this->table.doctor_id = doctors.doctor_id AND $this->table.patient_id = patients.patient_id";

            }
            
            $result = $database->query($sql);
            return $database->fetch_array($result);
        }

        public function get_mypatient(){
            global $database;

            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));

            $sql = "SELECT DISTINCT patients.patient_id, patient_name, patient_email, patient_contact, patient_country, patient_state, patient_address, patient_image, patients.userToken as userToken, height, weight FROM $this->table, patients, doctors WHERE 
                $this->table.doctor_id = '". $database->escape_value($this->Doctor_ID) ."'
                AND date <= '" . date("Y-m-d") . "'
                AND $this->table.doctor_id = doctors.doctor_id AND $this->table.patient_id = patients.patient_id";

            
            $result = $database->query($sql);
            return $database->fetch_array($result);
        }

        public function check_appointment(){
            global $database;
            $sql = "SELECT * FROM $this->table WHERE
            patient_id = '". $database->escape_value($this->Patient_ID) . "' AND
            doctor_id = '". $database->escape_value($this->Doctor_ID) . "' AND
            date = '". date('Y-m-d') . "' AND
            status = '1'";

            $result = $database->query($sql);
            $app = $database->fetch_row($result);
            if(empty($app)){
                return false;
            }else{
                return true;
            }
        }

        public function check_valid_mode(){
            global $database;
            if($database->escape_value($this->Appointment_Location) =="video"){
                $this->Appointment_Location = "Virtual Video Chat";
                $sql = "SELECT * FROM $this->table WHERE
                patient_id = '". $database->escape_value($this->Patient_ID) . "' AND
                doctor_id = '". $database->escape_value($this->Doctor_ID) . "' AND
                date = '". date('Y-m-d') . "' AND
                mode = 'Virtual Video Chat'";
            }else if($database->escape_value($this->Appointment_Location) =="voice"){
                $this->Appointment_Location = "Virtual Voice Chat";
                $sql = "SELECT * FROM $this->table WHERE
                patient_id = '". $database->escape_value($this->Patient_ID) . "' AND
                doctor_id = '". $database->escape_value($this->Doctor_ID) . "' AND
                date = '". date('Y-m-d') . "' AND
                mode = 'Virtual Voice Chat'";
            }else{
                return false;
            }
            $result = $database->query($sql);
            $app = $database->fetch_row($result);
            if(empty($app)){
                return false;
            }else{
                return true;
            }
        }

        public function check_appointment_feedback(){
            global $database;
            $sql = "SELECT * FROM $this->table WHERE
            patient_id = '". $database->escape_value($this->Patient_ID) . "' AND
            doctor_id = '". $database->escape_value($this->Doctor_ID) . "'";

            $result = $database->query($sql);
            $app = $database->fetch_row($result);
            if(empty($app)){
                return false;
            }else{
                return true;
            }
        }

        public function update_appointment_status(){
            global $database;

            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));
            $this->Patient_ID = trim(htmlspecialchars(strip_tags($this->Patient_ID)));
            $this->Appointment_Date = trim(htmlspecialchars(strip_tags(Date('Y-m-d'))));
            $this->Appointment_Status = trim(htmlspecialchars(strip_tags($this->Appointment_Status)));
            $this->Appointment_Location = trim(htmlspecialchars(strip_tags($this->Appointment_Location)));

            $sql = "UPDATE $this->table SET  
            `status` = '" . $database->escape_value($this->Appointment_Status) . "' WHERE 
            `mode` = '" . $database->escape_value($this->Appointment_Location) . "' AND
            `date` = '" . $database->escape_value($this->Appointment_Date) . "' AND
            `patient_id` = '". $database->escape_value($this->Patient_ID) ."' AND
            `doctor_id` = '". $database->escape_value($this->Doctor_ID) ."'";
            

            $appointment_saves = $database->query($sql);

            if($appointment_saves){
                return true;
            }else{
                return false;
            }
        }

        //Get Appointments with date
        public function get_appointment(){
            global $database;

            
            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));
            $this->Appointment_Date = trim(htmlspecialchars(strip_tags($this->Appointment_Date)));;

            $sql = "SELECT slot FROM $this->table WHERE 
            doctor_id = '". $database->escape_value($this->Doctor_ID) ."' AND
            date = '". $database->escape_value($this->Appointment_Date) ."'";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        }

        //Get Doctor Upcoming Appointment
        public function get_docupcomingapp(){
            global $database;

            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));
            $this->Appointment_Date = trim(htmlspecialchars(strip_tags($this->Appointment_Date)));;

            $sql = "SELECT Appointment_ID, Patient_Name, Patient_Contact, Patient_Image, Doctor_Name, Doctor_Contact, Doctor_Image, Appointment_Location, Appointment_Slot, Appointment_Date FROM $this->table, patients, doctors WHERE 
            $this->table.Doctor_ID = '". $database->escape_value($this->Doctor_ID) ."' AND
            Appointment_Date >= '". $database->escape_value($this->Appointment_Date) ."'
            AND $this->table.Doctor_ID = doctors.Doctor_ID AND $this->table.Patient_ID = patients.Patient_ID ORDER BY Appointment_Date";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        }
        //Get Doctor Past Appointment
        public function get_docpastapp(){
            global $database;

            $this->Doctor_ID = trim(htmlspecialchars(strip_tags($this->Doctor_ID)));
            $this->Appointment_Date = trim(htmlspecialchars(strip_tags($this->Appointment_Date)));;

            $sql = "SELECT Appointment_ID, Patient_Name, Patient_Contact, Patient_Image, Doctor_Name, Doctor_Contact, Doctor_Image, Appointment_Location, Appointment_Slot, Appointment_Date FROM $this->table, patients, doctors WHERE 
            $this->table.Doctor_ID = '". $database->escape_value($this->Doctor_ID) ."' AND
            Appointment_Date < '". $database->escape_value($this->Appointment_Date) ."'
            AND $this->table.Doctor_ID = doctors.Doctor_ID AND $this->table.Patient_ID = patients.Patient_ID ORDER BY Appointment_Date";

            $result = $database->query($sql);
            return $database->fetch_array($result);
        }
        //Get My DOctor

    }

    $appointment  = new Appointment();
    // $appointment->Appointment_Date = "2022-01-01";
    // $appointment->Appointment_Location = "Physical";
    // $appointment->Appointment_ID = "1";
    // $appointment->Appointment_Slot = "1";

    // echo ($appointment->update_appointment());
?>