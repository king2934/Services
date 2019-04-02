<?php
/*
 * Copyright 2019-2020 lanhuispace.com, Inc.
 * Email: king2934@126.com
 * @see http://docs.mongodb.org/manual/reference/connection-string/
 * @see http://php.net/manual/en/mongodb-driver-manager.construct.php
 * @see http://php.net/manual/en/mongodb.persistence.php#mongodb.persistence.typemaps
 * @param string $uri           MongoDB connection string
 * @param array  $uriOptions    Additional connection string options
 * @param array  $driverOptions Driver-specific options
 */

namespace com\lanhuispace\MongoDB;
use MongoDB\Driver\Manager;
class Utils
{
	private $Manager;
	private $ConnUrl;
	private $UriOptions;
	private $DriverOptions;
	private $UserName;
	private $PassWord;
	private $HostName;
	private $HostPort;
	private $DataBase;
	private $Collection;
	
	//设置配置文件 数组 
	public function setDefaultConfig($config)
	{
		$this->ConnUrl = "mongodb://";
		$config = array_change_key_case($config,CASE_LOWER);//CASE_LOWER=默认值小写字母,CASE_UPPER=大写字母
		
		if(!empty($config["username"]))//检查一个变量是否为空
		{
			$this->UserName = $config["username"];
			$this->PassWord = $config["password"];
			$this->ConnUrl .= $this->UserName.":".$this->PassWord."@";
		}
				
		if(!empty($config["hostname"]))
		{
			$this->HostName = $config["hostname"];
		}
		
		$this->ConnUrl .= $this->HostName;		
		
		if(!empty($config["hostport"]))
		{
			$this->HostPort = $config["hostport"];
		}

		$this->ConnUrl .= ":".$this->HostPort;
		
		if(!empty($config["database"]))
		{
			$this->DataBase = $config["database"];
			$this->ConnUrl .= "/".$this->DataBase;
		}
		
		if(!empty($config["collection"]))
		{
			$this->Collection = $config["collection"];
		}
		
		return $this->ConnUrl.".".$this->Collection;
	}
	
	//连接MongoDB数据库 public/private/protected
	protected function connection()
	{
		$this->Manager = new Manager($this->ConnUrl, $this->UriOptions, $this->DriverOptions);
	}
	
	public function query($where=[],$options=[])
	{
		$query = new \MongoDB\Driver\Query($where,$options);
		$cursor = new \MongoDB\Driver\executeQuery($this->DataBase.".".$this->Collection,$query);
		$result = $cursor->toArray();
		return $result;
	}
	
	//更新
	public function update($wheres=[],$options=[])
	{
		$bulk = new \MongoDB\Driver\BulkWrite();
		$bulk->update($wheres,array('$set'=>$options),array('multi'=>false,'upsert'=>true));
		return $this->Manager->executeBulkWrite($this->DataBase.'.'.$this->Collection, $bulk);
	}

	//
	public function command($cmd)
	{
		$command = new \MongoDB\Driver\Command($cmd);
		$cursor = $this->manager->executeCommand($this->DataBase.'.'.$this->Collection, $command);
		$result = $cursor;//->toArray();
		return $result;
	}
	
	//连接MongoDB数据库
	public function conn()
	{
		$this->connection();
	}
	
	//show databases
	public function showdbs()
	{
		return $this->ListDatabases();
	}
	
	//show Collections
	public function showcoll($database)
	{
		return $this->listCollections($database);
	}

	//列出数据库
	protected function listDatabases()
	{
		$cmd = ['listDatabases' => 1];
		$command = new \MongoDB\Driver\Command($cmd);
		$cursor = $this->manager->executeCommand('admin', $command);
		$cursor->setTypeMap(['root' => 'array', 'document' => 'array']);
		$result = current($cursor->toArray());
		if (  isset($result['databases']) ||  is_array($result['databases'])){
			return $result['databases'];
		}
	}

	//列出数据库中的集合
	protected function listCollections($database)
	{
		$cmd = ['listCollections' => 1];
		$command = new \MongoDB\Driver\Command($cmd);
		$cursor = $this->manager->executeCommand($database, $command);
		$cursor->setTypeMap(['root' => 'array', 'document' => 'array']);
		$result = $cursor->toArray();
		return $result;
	}

	//
	function __construct()
	{
		$this->UserName = null;
		$this->PassWord = null;
		$this->HostName = '127.0.0.1';
		$this->HostPort = 27017;
		$this->DataBase = null;
		$this->Collection = null;
		
		$this->ConnUrl = "mongodb://".$this->HostName.":".$this->HostPort;
		$this->UriOptions = array();
		$this->DriverOptions = array();
	}
	
	//
	function __destruct()
	{
		
	}
}
?>