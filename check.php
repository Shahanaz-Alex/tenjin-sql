<?php 
    require "connect.php";

    if($_SERVER['REQUEST_METHOD']=="POST"){
        $data = array();

        $emailAddress= $_POST['emailAddress'];
        $password = $_POST['password'];

        $sqlSelect = msqli_query($conn, "SELECT * FROM login WHERE emailAddress = '$emailAddress' AND password = '$password'");
        $result = mysqli_fetch_array($sqlSelect);

        if(isset($result) && $result != NULL){
            $data['msg'] = "Data Exists";
            $data['firstName'] = $result['firstName'];
            $data['lastName'] = $result['lastName'];
            $data['usertype'] = $result['usertype'];
            $data['emailAddress'] = $result['emailAddress'];
            echo json_encode($data);
        }else{
            $data['msg'] = "Data Missing";
            echo json_encode($data);
        }

    }

?>