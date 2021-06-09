<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "nkdelivery");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;

    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}


if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {

		$storeID = $_GET['storeID'];
		$latitude = $_GET['latitude'];
    $longitude = $_GET['longitude'];
    $p_img = $_GET['p_img'];

    $store_name = $_GET['store_name'];
    $commercial_number = $_GET['commercial_number'];
    $name_operator = $_GET['name_operator'];
    $phone_store = $_GET['phone_store'];
    $address_store = $_GET['address_store'];
    $timeopen = $_GET['timeopen'];
    $timeclose = $_GET['timeclose'];
    $dayopen = $_GET['dayopen'];
    $dayclose = $_GET['dayclose'];
    //$token = $_GET['token'];


		$sql = "UPDATE `store` SET `latitude` = '$latitude',`longitude` = '$longitude',`p_img` = '$p_img',
    `name_operator` = '$name_operator',
    `phone_store` = '$phone_store',
    `address_store` = '$address_store',
    `store_name` = '$store_name',
    `commercial_number` = '$commercial_number',
    `timeopen` = '$timeopen',
    `timeclose` = '$timeclose',
    `dayopen` = '$dayopen',
    `dayclose` = '$dayclose'

     WHERE storeID = '$storeID'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome";

}

	mysqli_close($link);
?>
