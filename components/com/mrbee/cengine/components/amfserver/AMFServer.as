package com.mrbee.cengine.components.amfserver
{
	import com.mrbee.cengine.CEngine;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	public class AMFServer
	{
		public static const EVENT_GROUP:String = "_NetConnection_";
		private static var _instance:AMFServer;
	
        private var _netConnection:NetConnection;
        private var _serverUrl:String;

		public function AMFServer(caller:Function = null):void
		{
			if( caller != AMFServer.getInstance )
                throw new Error ("AMFServer is a singleton class, use getInstance() instead");
            if ( AMFServer._instance != null )
                throw new Error( "Only one AMFServer instance should be instantiated" );
		}
		
		public static function getInstance():AMFServer
		{
			if (_instance == null)
				_instance = new AMFServer(arguments.callee);
			
			return _instance;
		}
		
		public function startGameServer():void {   
			
			_netConnection = new NetConnection();		
			_netConnection.maxPeerConnections = 1;
			_netConnection.objectEncoding = ObjectEncoding.AMF3;
			_netConnection.addHeader("Accept-Encoding: gzip");
			
			CEngine.eventManager.add(_netConnection, NetStatusEvent.NET_STATUS, connectionHandler, false, EVENT_GROUP);					
			_netConnection.connect(_serverUrl);			
		}
		
		public function close():void
		{
			CEngine.eventManager.removeGroup(EVENT_GROUP);			
			_netConnection.close();
		}
		
		private function connectionHandler(e:NetStatusEvent):void 
		{
			if (e.info.code == "NetConnection.Call.Failed")
				trace("Unable to find gateway");
		}
		
		public function call(functionName:String, responderClass:BaseResponder, ... arg):void {	

			var argument:Array = [];
				argument.push(functionName);
				argument.push(responderClass);
				argument.push.apply(null, arg);
			_netConnection.call.apply(null, argument);
		}
		
		public function get serverUrl():String { return _serverUrl; }
		
		public function set serverUrl(value:String):void 
		{
			_serverUrl = value;
		}

	}
}