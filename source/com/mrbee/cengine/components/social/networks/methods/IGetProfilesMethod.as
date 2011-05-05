package com.mrbee.cengine.components.social.networks.methods 
{
	import com.mrbee.cengine.components.social.networks.ISocialMethod;
	
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	
	public interface IGetProfilesMethod extends ISocialMethod
	{				
		function get uids():Array;
		
		function set uids(value:Array):void;
	}
	
}