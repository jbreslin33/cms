<?php 
//just in case start session again????
//session_start();

include_once(getenv("DOCUMENT_ROOT") . "/php/database/database.php");

class Login 
{
	function __construct() 
	{
		if (isset($_POST['username']) && isset($_POST['password']))
		{
			$_SESSION['username'] = $_POST['username'];
			$_SESSION['password'] = $_POST['password'];
		}	
		else
		{
			header("Location: http://elacore.org/index.php");
		}
			
		$this->processLogin();
	}

	public function processLogin()
	{
		$database = new Database;
		
		$query = "select id from users where username = '";
		$query .= $_SESSION['username']; 
		$query .= "' and password = '";
		$query .= $_SESSION['password']; 
		$query .= "';";
		
		$result = $database->query($query);
		if (pg_num_rows($result) > 0)
		{
			$_SESSION["logged_in"] = true;

			$row = pg_fetch_row($result);
			$_SESSION["user_id"] = $row[0];

			header("Location: http://elacore.org/main/main.php");
			die();
		}
		else
		{
			$_SESSION["logged_in"] = false;
			header("Location: http://elacore.org/index.php");
		}
	}
}

$login = new Login();

?>
