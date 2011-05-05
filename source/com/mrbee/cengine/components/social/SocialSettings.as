package com.mrbee.cengine.components.social 
{
	/**
	 * Social network settings
	 * @author Poluosmak Andrew
	 */
	
	public class SocialSettings
	{		
		public static const SETTINGS_NETWORK:Number = 0;
		public static const SETTINGS_VERSION:String = "product";
		
		public static var SETTINGS_NETWORK_INFO:Array = new Array();
		
		SETTINGS_NETWORK_INFO.push( { product: { app_id:1953583, app_key:"xBm2rU85zo", url: "http://api.vkontakte.ru/api.php", test_mode: 0, viewer_id:"5004493", auth_key:"cc9964d99d9ad8090659c4498832e8c2"},
									  dev: { app_id:1931739, app_key:"yH7dChUCll", url: "http://api.vkontakte.ru/api.php", test_mode: 1, viewer_id: "5004493", auth_key:"0a333b703c342e5a84b120efffefc7ec" },
									  devalisa: { app_id:1931739, app_key:"yH7dChUCll", url: "http://api.vkontakte.ru/api.php", test_mode: 1, viewer_id: "96714995", auth_key:"ae2ea0c27c80ceeaa175a9488b9a68bf" }
									} );
														  
		SETTINGS_NETWORK_INFO.push( { dev: { app_id:539909, app_key:"34b5119dfbed246526dca752c4639caf", url: "http://www.appsmail.ru/platform/api", test_mode: 1, viewer_id:"1652740824899299922", auth_key:"a4f5f22b27680396309d00c455db3692"},
									  product: { app_id:541365, app_key:"5d089f58e33110073a4c460b42600bf1", url: "http://www.appsmail.ru/platform/api", test_mode: 1, viewer_id: "1652740824899299922", auth_key:"a4f5f22b27680396309d00c455db3692" }
									} );
		
	}

}