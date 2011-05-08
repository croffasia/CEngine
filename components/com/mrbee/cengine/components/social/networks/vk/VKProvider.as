package com.mrbee.cengine.components.social.networks.vk 
{
	import com.adobe.serialization.json.JSON;
	import com.mrbee.cengine.components.social.networks.BaseProvider;
	import com.mrbee.cengine.components.social.networks.IProvider;
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
	
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	
	public class VKProvider extends BaseProvider
	{
		
		public function VKProvider() 
		{
			super();
		}
		
		override public function request(method: String, options: Object = null):void
		{
			var request_params:Object = {method: method};
				request_params.api_id = SocialFactory.getInstance().applicationID;
				request_params.format = "JSON";
				request_params.v = "3.0";				
				
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
			variables['sid'] = SocialFactory.getInstance().sid;
  
			_sendRequest(variables, options);
			
		}
		
	}

}