<?php

global $config;

function getAccessLevel($table, $user) {
    $config = include 'config.php';
    $database = mysqli_connect($config['mysql-host'], $config['mysql-username'], $config['mysql-password'], $config['mysql-database']);
    $query = $database->prepare("SELECT `accesslevel` FROM `" . $table . "` WHERE `user` = ?");
    $query->bind_param("s", $user);
    $query->execute();
    $query->bind_result($accesslevel);
    $query->fetch();
    if (isset($accesslevel)) {
        die("$accesslevel");
    } else {
        die("0");
    }
}

function main() {
    $user = NULL;
    $tablpe = NULL;
    if (isset($_GET['player'])) {
        $user = $_GET['player'];
        if (isset($_GET['group'])) {
            $table = $_GET['group'];
            getAccessLevel(base64_encode($table), $user);
        } else {
            die("group param isn't set.");
        }
    } else {
        die("player param isn't set.");
    }
}

main();
?>
