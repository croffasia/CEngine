package com.mrbee.cengine.components.social.networks 
{
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.mrbee.cengine.components.social.SocialFactory;
	import com.mrbee.cengine.utils.DelegateFunction;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.Security;

	/**
	 * @private
	 */
	public class BaseProvider implements IProvider
	{
		protected var onIOErrorDelegate:Function;
		protected var onSecurityErrorDelegate:Function;
		protected var onResultDelegate:Function;
		
		public function BaseProvider() 
		{
			
		}
		
		public function request(method: String, options: Object = null):void
		{
			var request_params:Object = {method: method};
				request_params.api_id = SocialFactory.getInstance().applicationID;
				request_params.format = "JSON";
				
			if (SocialFactory.getInstance().isTestMode)
				request_params.test_mode = "1";
				
			if (options.params) 
			{
				for (var i: String in options.params) 
				{
					request_params[i] = options.params[i];
				}
			}
			
			var variables:URLVariables = new URLVariables();
			
			for (var j: String in request_params) 
			{
				variables[j] = request_params[j];
			}
			
			variables['sig'] = _generate_signature(request_params);
  
			_sendRequest(variables, options);
			
		}
		
		protected function _sendRequest(variables:URLVariables, options:Object):void
		{
			Security.allowDomain("*");
			
			var request:URLRequest = new URLRequest();
				request.url = SocialFactory.getInstance().apiUrl;
				request.method = URLRequestMethod.POST;
				request.data = variables;
  
			var loader:URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				
			//if (options.onError) 
			//{
				onIOErrorDelegate = DelegateFunction.create(onIOError, options, loader);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorDelegate);
			
				onSecurityErrorDelegate = DelegateFunction.create(onSecurityError, options, loader);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorDelegate);
			//} else {
			
			//}
			
			onResultDelegate = DelegateFunction.create(onResult, options, loader);
			loader.addEventListener(Event.COMPLETE, onResultDelegate);
			loader.load(request);
		}
		
		protected function _generate_signature(request_params: Object): String 
		{
			var signature: String = "";
			var sorted_array: Array = new Array();
			
			for (var key: String in request_params) 
			{
				sorted_array.push(key + "=" + request_params[key]);
			}
			
			sorted_array.sort();

			for (key in sorted_array) {
				signature += sorted_array[key];
			}
			
			signature = SocialFactory.getInstance().viewerID.toString() + signature;
			signature += SocialFactory.getInstance().applicationSecretKey;
		  
			return MD5.hash(signature);
		}
		
		public function onIOError(e:IOErrorEvent, options:Object, loader:URLLoader):void
		{
			if(options.onError != null){
				options.onError("Connection error occured");
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorDelegate);
				onIOErrorDelegate = null;
			}
		}
		
		public function onSecurityError(e:SecurityErrorEvent, options:Object, loader:URLLoader):void
		{
			if(options.onError != null){
				options.onError("Connection error occured");
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorDelegate);
				onSecurityErrorDelegate = null;
			}
		}
		
		public function onResult(e:Event, options:Object, loader:URLLoader):void
		{
			options.onError("Connection error occured");
			
			var data:Object = JSON.decode(loader.data);
			
			if (data.error) 
			{
				options.onError("loader - "+String(data.error));					
			} else if (options.onComplete && data.response) {
				options.onComplete(data.response);
			}
			
			if(onResultDelegate != null)
				loader.removeEventListener(Event.COMPLETE, onResultDelegate);
			
			onResultDelegate = null;
		}
	}

}