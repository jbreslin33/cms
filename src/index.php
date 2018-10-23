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

<form action="/php/classes/login/login.php" method="post">

<div class="login">
    <input type="text" placeholder="Email" id="username" name="username">  
  <input type="password" placeholder="password" id="password" name="password">  
  <a href="#" class="forgot">forgot password?</a>
  <input type="submit" value="Sign In">
</div>

</form>
<div class="shadow"></div>

</body>
</html>
