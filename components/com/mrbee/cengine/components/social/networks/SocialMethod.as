package com.mrbee.cengine.components.social.networks 
{
	/**
	 * Методы АПИ социльной сети
	 * @author Poluosmak Andrew
	 */
	public class SocialMethod
	{		
		/** 
		 * Получение профайла пользователя 
		 */
		public static const GET_PROFILES:String = "profile";
		
		/** 
		 * Получение списка друзей
		 */
		public static const GET_FRIENDS:String = "friends";
		
		/** 
		 * Получение списка друзей, которые установили приложение 
		 */
		public static const GET_APP_FRIENDS:String = "appfriends";
		
		/** 
		 * Отправка сообщения в новостную ленту пользователя 
		 */
		public static const POST_NEWS_FEED:String = "postnewsfeed";
		
		/** 
		 * Отправка сообщения на стену (гостеву. книгу) пользователя 
		 */
		public static const POST_WALL:String = "postwall";
		
		/** 
		 * Получение информации   
		 */
		public static const GET_BALANCE:String = "getbalance";
		
		/** 
		 * Вызов стандартного окна внесения оплаты
		 */
		public static const SHOW_PAYMENT_BOX:String = "showpaymentbox";
		
		/** 
		 * Вызов стандартного окна настроек приложения социальной сети 
		 */
		public static const SHOW_SETTINGS_BOX:String = "showsettingsbox";
		
		/** 
		 * Вызов стандартного окна приглашения друзей социальной сети 
		 */
		public static const SHOW_INVITE_BOX:String = "showinvitebox";
		
	}

}