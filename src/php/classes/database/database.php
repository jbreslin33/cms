<?php 
class Database 
{
	private $mConnection 	   = NULL;
	private $mConnectionString = "host=localhost dbname=cms user=postgres password=mibesfat";
	private $mResult 	   = NULL;		 
	
	function __construct() 
	{
		$this->setConnectionString($this->mConnectionString);
        	$this->mConnection = pg_connect($this->mConnectionString);
	}

	public function getConnection()
	{
		return $this->$mConnection;
	}

	public function setConnectionString($connectionString)
	{
		$this->mConnectionString = $connectionString;
	}
	
	public function query($query)
	{
  		$this->mResult = pg_query($this->mConnection,$query);
		return $this->mResult;
	}
}


?>

