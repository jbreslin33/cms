<?php
session_start();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Club Management System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<form action="/php/login/login.php" method="post">
First name: <input type="text" name="username"><br>
Last name: <input type="text" name="password"><br>
<input type="submit" value="Login">
</form>

</body>
</html>
