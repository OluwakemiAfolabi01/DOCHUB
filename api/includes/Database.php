<?php

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..') . $ds;

require_once("{$base_dir}config{$ds}config.php"); //Define Database information here. Example below:

    /*
    define('HOST', 'localhost');
    define('USER_NAME', 'root');
    define('PASSWORD', '');
    define('DB_NAME', 'doctorhub');

    */

// Database Class
class Database{
    private $connection;

    //DB Constructor
    public function __construct() {
        $this->open_db_connection();
    }

    //Creating connection with DB
    public function open_db_connection(){
        $this->connection = mysqli_connect(HOST, USER_NAME, PASSWORD, DB_NAME);

        if(mysqli_connect_error()){
            die("Connection Error : " . mysqli_connect_error());
        }
    }

    public function query($sql){
        $result = $this->connection->query($sql);

        if(!$result){
            die('Query fails : '. $sql);
        }

        return $result;
    }

    public function fetch_array($result){
        if($result->num_rows > 0) {
            while($row = $result->fetch_assoc()){
                $result_array[] = $row;
            }
            return $result_array;
        }else{
            return [];
        }
    }

    public function fetch_row($result){
        if($result->num_rows > 0){
            return $result->fetch_assoc();
        }
    }

    public function escape_value($value){
        return $this->connection->real_escape_string($value);
    }

    public function close_connection(){
        $this->connection ->close();
    }

}

$database = new Database();

?>