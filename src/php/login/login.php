<?php 
include_once(getenv("DOCUMENT_ROOT") . "/php/database/database.php");

class Login 
{
	private $mUsername  = NULL;
	private $mPassword  = NULL;

	private $mLoggedIn = false; 
	
	function __construct() 
	{
		$this->mUsername = $_POST["username"];
		$this->mPassword = $_POST["password"];

		$this->processLogin();
	}

	public function processLogin()
	{
		$database = new Database;
		
		$query = "select id from users where username = '";
		$query .= $this->mUsername; 
		$query .= "' and password = '";
		$query .= $this->mPassword; 
		$query .= "';";
		
		$result = $database->query($query);
		if (pg_num_rows($result) > 0)
		{
			error_log("successful login");
			header("Location: http://elacore.org/main/main.php");
			die();
		}
		else
		{
			error_log("unsuccessful login");
			header("Location: http://elacore.org/index.php");
		}
	}
}

$login = new Login();

?>
