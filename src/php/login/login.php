<?php 
include_once(getenv("DOCUMENT_ROOT") . "/php/database/database.php");

//$database = new Database;
//$database->query("insert into ages (name) values ('yo')");


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
			echo "successful login";
		}
		else
		{
			echo "unsuccessful login";
		}
	}

	public function setConnectionString($connectionString)
	{
		//$this->mConnectionString = $connectionString;
	}
	
	public function query($query)
	{
  		//$this->mResult = pg_query($this->mConnection,$query);
		//return $this->mResult;
	}
}

$login = new Login();


?>

