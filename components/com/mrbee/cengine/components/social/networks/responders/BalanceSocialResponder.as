package com.mrbee.cengine.components.social.networks.responders 
{
	import com.mrbee.cengine.components.social.networks.ISocialResponder;
	
	/**
	 * Объект ответа метода API социальной сети "баланс пользователя"
	 * @see com.mrbee.cengine.components.social.networks.SocialMethod#GET_BALANCE
	 * @author Poluosmak Andrew
	 */
	
	public class BalanceSocialResponder implements ISocialResponder
	{
		/**
		 * @private
		 */
		private var _balance:Number = 0;
		
		/**
		 * @private
		 */
		public function BalanceSocialResponder(){}
		
		/**
		 * Баланс пользователя
		 */
		public function get balance():Number { return _balance; }
		
		/**
		 * @private
		 */
		public function set balance(value:Number):void 
		{
			_balance = value;
		}
		
		
	}

}