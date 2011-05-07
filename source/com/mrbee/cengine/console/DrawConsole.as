/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console
{
	import com.mrbee.cengine.CEngine;
	
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
		
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	public class DrawConsole extends Sprite
	{		 		
		protected var _logTf:TextField;
		private var _symTf:TextField;
		public var _enterTf:TextField;
		
		private var _linkButtonClear:TextField;
		
		private var PerfoBold:Font;
		
		public function DrawConsole()
		{
			super();			
			
			PerfoBold = new MicrosoftSansSerif();
			tabChildren = false;
		}
		
		public function draw():void
		{
			var height:int = Math.ceil(CEngine.mainStage.stage.stageHeight / 2);
			graphics.clear();
			graphics.beginFill(0x000000, 1);
			graphics.drawRect(0, 0, CEngine.mainStage.stage.stageWidth, height - 25);
			graphics.endFill();
			graphics.beginFill(0x14260b, 1);
			graphics.drawRect(0, height - 25, CEngine.mainStage.stage.stageWidth, 25);
			graphics.endFill();					
			
			drawTextFields();
		}			
		
		protected function addToLogTf(message:String):void
		{
			_logTf.htmlText = message;
			
			var tf:TextFormat = _logTf.getTextFormat();
			tf.size = 11;
			tf.font = PerfoBold.fontName;
			
			_logTf.setTextFormat(tf);
		}
		
		private function drawTextFields():void
		{
			var tf:TextFormat;

			_logTf = new TextField();
			_logTf.width = CEngine.mainStage.stage.stageWidth - 10; 
			_logTf.height = height - 35;
			_logTf.x = 5;
			_logTf.y = 5;
			_logTf.antiAliasType = AntiAliasType.ADVANCED;
			_logTf.embedFonts = true;	
			
			_logTf.mouseEnabled = false;
			
			
			addToLogTf("");					
			addChild(_logTf);
			
			_symTf = new TextField();
			_symTf.width = 100; 
			_symTf.height = 25;
			_symTf.x = 5;
			_symTf.antiAliasType = AntiAliasType.ADVANCED;
			_symTf.y = _logTf.height + 14;
			_symTf.selectable = false;
			_symTf.text = "Command line: ";
			_symTf.embedFonts = true;
			
			tf = _symTf.getTextFormat();
			tf.size = 12;
			tf.font = PerfoBold.fontName;
			tf.color = 0xffffff;
			
			_symTf.setTextFormat(tf);
			
			addChild(_symTf);
			
			_enterTf = new TextField();
			_enterTf.text = " ";
			_enterTf.text = "";
			
			tf = _enterTf.getTextFormat();
			tf.size = 12;
			tf.font = PerfoBold.fontName;
			tf.color = 0xffffff;
			
			_enterTf.setTextFormat(tf);
			_enterTf.embedFonts = true;
			_enterTf.selectable = true;
			_enterTf.mouseWheelEnabled = false;
			_enterTf.antiAliasType = AntiAliasType.ADVANCED;
			
			_enterTf.width = CEngine.mainStage.stage.stageWidth - 105; 
			_enterTf.height = 25;
			_enterTf.backgroundColor = 0x1a2d11;
			_enterTf.x = 100;		
			_enterTf.type = TextFieldType.INPUT;
			_enterTf.useRichTextClipboard = true;
			_enterTf.y = _logTf.height + 14;
			
			addChild(_enterTf);			
		}
	}
}