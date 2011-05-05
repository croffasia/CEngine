package com.mrbee.cengine.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class LanguageEvent extends Event 
	{
		public static const SET_LANGUAGE:String = "_LanguageEvent_SetLanguage_";
		
		public var languageID:String = "";
		
		public function LanguageEvent(type:String, lang:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
			languageID = lang;
		} 
		
		public override function clone():Event 
		{ 
			return new LanguageEvent(type, languageID, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LanguageEvent", "type", "languageID", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}