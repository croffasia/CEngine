package com.mrbee.cengine.components.social.networks.vk.methods 
{
	import com.mrbee.cengine.components.social.networks.methods.IGetBalanceMethod;
	import com.mrbee.cengine.components.social.networks.responders.BalanceSocialResponder;
	import com.mrbee.cengine.components.social.SocialFactory;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class GetBalance implements IGetBalanceMethod
	{				
		private var _onResult:Function;
		private var _onFail:Function;
		
		public function GetBalance(onResult:Function, onFail:Function) 
		{
			_onFail = onFail;
			_onResult = onResult;
		}
		
		public function call():void
		{
			SocialFactory.getInstance().provider.request("getUserBalance", { onComplete: onResultHandler, onError: onFailHandler});
		}
		
		/**
		 * Main result method callback
		 * @param	e
		 */
		public function onResultHandler(response:*):void
		{
			var responderBalance:BalanceSocialResponder;
			
			for (var key:String in response) {
				
				responderBalance = new BalanceSocialResponder();
				
				responderBalance.balance = response[key];				
			}
					
			if (_onResult != null)
				_onResult(responderBalance);	
		}
		
		/**
		 * Main fail method callback
		 * @param	e
		 */
		public function onFailHandler(e:*):void
		{
			var a:int;
		}
		
	}

}