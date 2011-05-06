/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.utils 
{
	/**
	 * Утилита для создания делигатов функции
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class DelegateFunction
	{		
		public static function create( handler:Function, ...args ):Function
        {
            return function(...innerArgs):*
            {
                return handler.apply( this, innerArgs.concat( args ) );
            }
        }
		
	}

}