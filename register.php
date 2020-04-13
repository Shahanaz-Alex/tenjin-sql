<?php 

    require "connect.php";

    if($_SERVER['REQUEST_METHOD'] == "POST"){
        $data = array();

        $firstName = $_POST['firstName'];
        $lastName = $_POST['lastName'];
        $emailAddress = $_POST['emailAddress'];
        $password = $_POST['password'];
        $usertype = $_POST['usertype'];

        $sqlSelect = "SELECT * FROM login WHERE firstName = '$firstName' AND lastName = '$lastName' AND emailAddress = '$emailAddress' AND password = '$password'AND usertype = '$usertype'"; 
        $result = $conn->query($sqlSelect);

        if(isset($result)){
            $data['status'] = 1;
            $data['msg'] = 'Record already exists, please login';
            echo json_encode($data);
        }else{
            $sqlInsert = "INSERT INTO login (firstName, lastName, emailAddress, password, usertype) VALUES (NULL, '$firstName', '$lastName', '$emailAddress', '$password', '$usertype')";

            if($conn-> query($sqlInsert)== TRUE){
                $data['status'] = 2;
                $data['msg'] = 'You have been successfully registered';
                echo json_encode($data);
            }else{
                $data['status'] = 3;
                $data['msg'] = 'Error: Cannot add your data at this time';
                echo json_encode($data);
            }
        }


    }
?>