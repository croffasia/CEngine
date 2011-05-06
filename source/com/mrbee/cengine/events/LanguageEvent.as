/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.events 
{
	import flash.events.Event;
	
	/**
	 * События для смены текущего языка в менеджере языков. 
	 * Диспетчером является CEngine.eventDispatcher
	 * 
	 * @see com.mrbee.cengine.CEngine#eventDispatcher
	 * @author Poluosmak Andrew
	 */
	public class LanguageEvent extends Event 
	{
		/**
		 * Запрашивает смену текущего языка
		 */
		public static const SET_LANGUAGE:String = "_LanguageEvent_SetLanguage_";
		
		/**
		 * Идентификатор требуемого языка
		 */
		public var languageID:String = "";
		
		/**
		 * @private
		 */
		public function LanguageEvent(type:String, lang:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
			languageID = lang;
		} 
		
		/**
		 * @private
		 */
		public override function clone():Event 
		{ 
			return new LanguageEvent(type, languageID, bubbles, cancelable);
		} 
		
		/**
		 * @private
		 */
		public override function toString():String 
		{ 
			return formatToString("LanguageEvent", "type", "languageID", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}