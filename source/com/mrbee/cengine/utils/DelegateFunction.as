package com.mrbee.cengine.utils 
{
	/**
	 * Утилита для создания делигатов на функции.
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