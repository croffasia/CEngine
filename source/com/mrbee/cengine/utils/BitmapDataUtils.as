/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * @private
	 */
	public class BitmapDataUtils
	{
		/**
		 * Pass these constants into the getResizedBitmapData() function
		 */
		public static const RESIZE_SCALE:String = 'BitmapDataUtils.resizeScale';
		public static const RESIZE_LETTERBOX:String = 'BitmapDataUtils.resizeLetterbox';
		public static const RESIZE_CROP:String = 'BitmapDataUtils.resizeCrop';
		
		/**
		 * Return a snapshot of a DisplayObject
		 */
		public static function getBitmapData( vSource:DisplayObject, vW:Number=NaN, vH:Number=NaN, vTransparent:Boolean=true, vColor:int=0xFF00FF, vMatrix:Matrix=null ):BitmapData
		{
			// set defaults.
			var vWidth:int = ( isNaN( vW )) ? vSource.width : vW;
			var vHeight:int = ( isNaN( vH )) ? vSource.height : vH;  
			
			// create BitmapData object.
			var vBmp:BitmapData = new BitmapData( vWidth, vHeight, vTransparent, vColor );
			
			// draw contents of source clip into target.
			if ( vMatrix == null ) vBmp.draw( vSource, null, null, null, null, true );
			else vBmp.draw( vSource, vMatrix, null, null, null, true ); 
			
			return vBmp;
		}
		
		/**
		 * Build & return a matrix to use to scale a bitmap
		 */
		public static function getScaleMatrix( scale:Number ) : Matrix
		{
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			return matrix;
		}
		
		/**
		 * Return a resized BitmapData copy of the original
		 */
		public static function getResizedBitmapData( sourceBitmap:BitmapData, targetWidth:Number, targetHeight:Number, resizingMethod:String = '', disposeSourceBmp:Boolean = true ) : BitmapData
		{
			// get current dimensions
			var curW:Number = sourceBitmap.width;
			var curH:Number = sourceBitmap.height;
			
			// get ratios of 2 sides
			var ratio_w:Number = targetWidth / curW;
			var ratio_h:Number = targetHeight / curH;
			var shorterRatio:Number = ( ratio_w > ratio_h ) ? ratio_h : ratio_w;
			var longerRatio:Number = ( ratio_w > ratio_h ) ? ratio_w : ratio_h;
			
			var resizedWidth:int;
			var resizedHeight:int;
			var resizedSourceBmp:BitmapData;
			var matrix:Matrix;
			var destBitmap:BitmapData;
			
			// apply sizing
			switch( resizingMethod )
			{
				case RESIZE_CROP :
					// get shorter ratio, so we fill the target area
					resizedWidth = Math.round( curW * longerRatio );
					resizedHeight = Math.round( curH * longerRatio );
					
					// create copy of, and resize the source bitmap
					resizedSourceBmp = new BitmapData( resizedWidth, resizedHeight, false, 0x00000000 );
					// create scale matrix 
					matrix = new Matrix();
					matrix.scale( longerRatio, longerRatio );
					// take resized snapshot
					resizedSourceBmp.draw( sourceBitmap, matrix );
					
					// draw into destination bitmap, letterbox/pillowbox style
					destBitmap = new BitmapData( targetWidth, targetHeight, false, 0x00000000 );
					var offset:Point = new Point( targetWidth / 2 - resizedWidth / 2, targetHeight / 2 - resizedHeight / 2 );
					destBitmap.copyPixels( resizedSourceBmp, new Rectangle( -offset.x, -offset.y, resizedSourceBmp.width, resizedSourceBmp.height ), new Point() );
					
					// clean up temp BitmapData
					resizedSourceBmp.dispose();
					if( disposeSourceBmp ) sourceBitmap.dispose();
					
					return destBitmap;
					break;
				
				case RESIZE_LETTERBOX :
					// get shorter ratio, so we fill the target area
					resizedWidth = Math.round( curW * shorterRatio );
					resizedHeight = Math.round( curH * shorterRatio );
					
					// create copy of, and resize the source bitmap
					resizedSourceBmp = new BitmapData( resizedWidth, resizedHeight, false, 0x00000000 );
					// create scale matrix 
					matrix = new Matrix();
					matrix.scale( shorterRatio, shorterRatio );
					// take resized snapshot
					resizedSourceBmp.draw( sourceBitmap, matrix );
					
					// draw into destination bitmap, letterbox/pillowbox style
					destBitmap = new BitmapData( targetWidth, targetHeight, false, 0x00000000 );
					var pastePoint:Point = new Point( targetWidth / 2 - resizedWidth / 2, targetHeight / 2 - resizedHeight / 2 );
					destBitmap.copyPixels( resizedSourceBmp, new Rectangle( 0, 0, resizedSourceBmp.width, resizedSourceBmp.height ), pastePoint );
					
					// clean up temp BitmapData
					resizedSourceBmp.dispose();
					if( disposeSourceBmp ) sourceBitmap.dispose();
					
					return destBitmap;
					break;
				
				case RESIZE_SCALE :
				default : 
					// create output bitmap
					var vBmp:BitmapData = new BitmapData( targetWidth, targetHeight, false, 0x00000000 );
					// create scale matrix 
					matrix = new Matrix();
					matrix.scale( ratio_w, ratio_h );
					// snapshot with scale and return
					vBmp.draw( sourceBitmap, matrix );
					
					// clean up temp BitmapData
					if( disposeSourceBmp ) sourceBitmap.dispose();
					
					return vBmp;
					break; 
				
			}
			return null;
		}
	}
}