<?php 
error_log('top of login.php');


class Login 
{
	private $mUsernameAttempt  = NULL;
	private $mPasswordAttempt  = NULL;
	private $mUsernameDatabase = NULL;
	private $mPasswordDatabase = NULL;

	private $mLoggedIn = false; 
	
	function __construct() 
	{
		$this->mUsernameAttempt = $_POST["username"];
		echo $this->mUsernameAttempt;	
	}

	public function processLogin()
	{
		//return $this->$mConnection;
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

