<?php 
//just in case start session again????
//session_start();

include_once(getenv("DOCUMENT_ROOT") . "/php/classes/database/database.php");

/*

codes
---------------
100 success
101 please provide a username and a password  
102 please provide a username  
103 please provide a password  
104 user does not exist
105 wrong password

everything else will be done on client

*/

class Login 
{
	function __construct() 
	{

		if (isset($_POST['username']) && isset($_POST['password']))
		{
			$_SESSION['username'] = $_POST['username'];
			$_SESSION['password'] = $_POST['password'];
		}
		if (isset($_GET['username']) && isset($_GET['password']))
		{
			$_SESSION['username'] = $_GET['username'];
			$_SESSION['password'] = $_GET['password'];
		}

		if (!isset($_SESSION['username']) && !isset($_SESSION['password']))
		{
			header("Location: http://elacore.org/index.php?code=101");
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

			error_log('successful login');

			header("Location: http://elacore.org/main/main.php");
			die();
		}
		else
		{
			error_log('unsuccessful login');
			$_SESSION["logged_in"] = false;
			header("Location: http://elacore.org/index.php");
		}
	}
}

$login = new Login();

?>
