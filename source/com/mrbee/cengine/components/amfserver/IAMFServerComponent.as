package com.mrbee.cengine.components.amfserver 
{
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public interface IAMFServerComponent 
	{
		function onResultHandler(responce:BaseResponder):void;
		function onStatusHandler(responce:BaseResponder):void;
	}
	
}