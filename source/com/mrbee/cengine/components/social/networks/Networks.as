package com.mrbee.cengine.components.social.networks 
{
	import com.mrbee.cengine.components.social.networks.mm.*;
	import com.mrbee.cengine.components.social.networks.vk.*;
	
	import flash.utils.Dictionary;
	
	/**
	 * Настройка компонента социальных сетей
	 */
	public class Networks
	{
		
		/** 
		 * ВКонтакте - http://vkontakte.ru, http://vk.com 
		 */
		public static const VK:String = "vkontakte";
		
		/** 
		 * Мой мир@mail.ru - http://my.mail.ru 
		 */
		public static const MM:String = "moymir";		
		
		/** 
		 * @private 
		 */
		public static var SocialEngines:Dictionary = new Dictionary();
		
		SocialEngines[VK] = {provider: VKProvider }
	}

}