/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console.logger
{
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	public class LoggerTemplates
	{
		public static function ERROR(message:String, time:Date = null):String
		{
			if(time == null)
				return ('<font color="#CC0000"><b>'+LogItem.ERROR+':</b> '+message+'</font>');
			else
				return ('<font color="#CC0000"><b>'+LogItem.ERROR+' ('+time.getHours()+'h '+time.getMinutes()+'m '+time.getSeconds()+'s '+time.getMilliseconds()+'ms):</b> '+message+'</font>');
		}
		
		public static function NOTICE(message:String, time:Date = null):String
		{
			if(time == null)
				return ('<font color="#FF9900"><b>'+LogItem.NOTICE+':</b> '+message+'</font>');
			else
				return ('<font color="#FF9900"><b>'+LogItem.NOTICE+' ('+time.getHours()+'h '+time.getMinutes()+'m '+time.getSeconds()+'s '+time.getMilliseconds()+'ms):</b> '+message+'</font>');
		} 
		 
		public static function INFO(message:String, time:Date = null):String
		{			
			if(time == null)
				return ('<font color="#efefef;"><b>'+LogItem.INFO+':</b> '+message+'</font>');
			else
				return ('<font color="#efefef;"><b>'+LogItem.INFO+' ('+time.getHours()+'h '+time.getMinutes()+'m '+time.getSeconds()+'s '+time.getMilliseconds()+'ms):</b> '+message+'</font>');
		} 
	}
}