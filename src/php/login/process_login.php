<?php

include_once(getenv("DOCUMENT_ROOT") . "/php/database/database.php");
error_log('home you');

$database = new Database;
$database->query("insert into ages (name) values ('yo')");

?>
