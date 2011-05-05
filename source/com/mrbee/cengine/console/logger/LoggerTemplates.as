package com.mrbee.cengine.console.logger
{
	/**
	 * @private
	 */
	public class LoggerTemplates
	{
		protected static function setError(message:String):String
		{
			return ('<font color="#CC0000"><b>ERROR:</b> '+message+'</font>');
		}
		
		protected static function setNotice(message:String):String
		{
			return ('<font color="#FF9900"><b>NOTICE:</b> '+message+'</font>');
		} 
		
		protected static function setInfo(message:String):String
		{
			return ('<font color="#999999;"><b>INFO:</b> '+message+'</font>');
		} 
	}
}