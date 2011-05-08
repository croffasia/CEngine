package com.mrbee.cengine.components.social.networks.responders 
{
	import com.mrbee.cengine.components.social.networks.ISocialResponder;
	
	/**
	 * Объект ответа метода API социальной сети "профайл пользователя". Используется во всех методах API, которые получают информацию о профайле пользователя в соиальной сети.
	 * @see com.mrbee.cengine.components.social.networks.SocialMethod#GET_PROFILES
	 * @see com.mrbee.cengine.components.social.networks.SocialMethod#GET_FRIENDS
	 * @see com.mrbee.cengine.components.social.networks.SocialMethod#GET_APP_FRIENDS
	 * @author Poluosmak Andrew
	 */
	
	public class ProfileSocialResponder implements ISocialResponder
	{
		/** 
		 * @private 
		 */
		private var _socialID:String = "";
		
		/** 
		 * @private 
		 */
		private var _firstName:String = "";
		
		/** 
		 * @private 
		 */
		private var _lastName:String = "";
		
		/** 
		 * @private 
		 */
		private var _sex:int = 0;
		
		/** 
		 * @private 
		 */
		private var _isOnline:int = 0;
		
		/** 
		 * @private 
		 */
		private var _bDate:String = "";
		
		/** 
		 * @private 
		 */
		private var _city:String = "";
		
		/** 
		 * @private 
		 */
		private var _country:String = "";
		
		/** 
		 * @private 
		 */
		private var _photoSmall:String = "";
		
		/** 
		 * @private 
		 */
		private var _photoMedium:String = "";
		
		/** 
		 * @private 
		 */
		private var _photoBig:String = "";
		
		/** 
		 * @private 
		 */
		private var _hasMobile:int = 0;
		
		/** 
		 * @private 
		 */
		private var _rate:Number = 0;		
		
		/** 
		 * @private 
		 */
		public function ProfileSocialResponder(){}
		
		/**
		 * Реальное имя пользователя
		 */
		public function get firstName():String { return _firstName; }
				
		/** 
		 * @private 
		 */
		public function set firstName(value:String):void 
		{
			_firstName = value;
		}
		
		/**
		 * Фамилия пользователя
		 */
		public function get lastName():String { return _lastName; }
		
		/** 
		 * @private 
		 */
		public function set lastName(value:String):void 
		{
			_lastName = value;
		}
		
		/**
		 * ID пользователя в социальной сети
		 */
		public function get socialID():String { return _socialID; }
		
		/** 
		 * @private 
		 */
		public function set socialID(value:String):void 
		{
			_socialID = value;
		}
		
		/**
		 * Пол пользователя 
		 * <ul><li>0 - не определен;</li><li>1 - женский;</li><li>2 - мужской;</li></ul> 
		 */
		public function get sex():int { return _sex; }
		
		/** 
		 * @private 
		 */
		public function set sex(value:int):void 
		{
			_sex = value;
		}
		
		/**
		 * Get user online status: 
		 * <ul><li>1 - в сети;</li><li>0 - офлайн;</li></ul>
		 */
		public function get isOnline():int { return _isOnline; }
		
		/** 
		 * @private 
		 */
		public function set isOnline(value:int):void 
		{
			_isOnline = value;
		}
		
		/**
		 * Дата рождения в формате dd.mm.yyyy
		 */
		public function get bDate():String { return _bDate; }
		
		/** 
		 * @private 
		 */
		public function set bDate(value:String):void 
		{
			_bDate = value;
		}
		
		/**
		 * Город пользователя
		 */
		public function get city():String { return _city; }
		
		/** 
		 * @private 
		 */
		public function set city(value:String):void 
		{
			_city = value;
		}
		
		/**
		 * Страна пользователя
		 */
		public function get country():String { return _country; }
		
		/** 
		 * @private 
		 */
		public function set country(value:String):void 
		{
			_country = value;
		}
		
		/**
		 * Ссылка на маленький автар пользователя
		 */
		public function get photoSmall():String { return _photoSmall; }
		
		/** 
		 * @private 
		 */
		public function set photoSmall(value:String):void 
		{
			_photoSmall = value;
		}
		
		/**
		 * Ссылка на средний размер аватара пользователя
		 */
		public function get photoMedium():String { return _photoMedium; }
		
		/** 
		 * @private 
		 */
		public function set photoMedium(value:String):void 
		{
			_photoMedium = value;
		}
		
		/**
		 * Ссылка на полный размер аватара пользователя
		 */
		public function get photoBig():String { return _photoBig; }
		
		/** 
		 * @private 
		 */
		public function set photoBig(value:String):void 
		{
			_photoBig = value;
		}
		
		/**
		 * Информация об активации пользователем анкеты по мобильному телефону
		 * <ul><li>0 - активированна;</li><li>0 - не активированна;</li></ul>
		 */
		public function get hasMobile():int { return _hasMobile; }
		
		/** 
		 * @private 
		 */
		public function set hasMobile(value:int):void 
		{
			_hasMobile = value;
		}
		
		/**
		 * Рейтинг пользователя
		 */
		public function get rate():Number { return _rate; }
		
		/** 
		 * @private 
		 */
		public function set rate(value:Number):void 
		{
			_rate = value;
		}
		
	}

}