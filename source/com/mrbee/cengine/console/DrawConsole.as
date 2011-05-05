package com.mrbee.cengine.console
{
	import com.mrbee.cengine.CEngine;
	
	import flash.display.Sprite;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import mx.controls.Text;
	
	/**
	 * @private
	 */
	public class DrawConsole extends Sprite
	{		 		
		protected var _logTf:TextField;
		private var _symTf:TextField;
		public var _enterTf:TextField;
		
		private var PerfoBold:Font;
		
		public function DrawConsole()
		{
			super();			
			
			PerfoBold = new MicrosoftSansSerif();
			tabChildren = false;
		}
		
		public function draw():void
		{
			graphics.clear();
			graphics.beginFill(0x000000, 0.6);
			graphics.drawRect(0, 0, CEngine.mainStage.stage.stageWidth, Math.ceil(CEngine.mainStage.stage.stageHeight / 2));
			graphics.endFill();		
			
			drawTextFields();
		}			
		
		protected function addToLogTf(message:String):void
		{
			_logTf.htmlText = message;
			
			var tf:TextFormat = _logTf.getTextFormat();
			tf.size = 11;
			tf.font = PerfoBold.fontName;
			tf.color = 0xffffff;
			
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
			_logTf.embedFonts = true;	
			
			addToLogTf("");					
			addChild(_logTf);
			
			_symTf = new TextField();
			_symTf.width = 100; 
			_symTf.height = 25;
			_symTf.x = 5;
			_symTf.y = _logTf.height + 5;
			_symTf.selectable = false;
			_symTf.text = "Command line: ";
			_symTf.embedFonts = true;
			
			tf = _symTf.getTextFormat();
			tf.size = 13;
			tf.font = PerfoBold.fontName;
			tf.color = 0xffffff;
			
			_symTf.setTextFormat(tf);
			
			addChild(_symTf);
			
			_enterTf = new TextField();
			_enterTf.text = "enter your command";
			
			tf = _enterTf.getTextFormat();
			tf.size = 13;
			tf.font = PerfoBold.fontName;
			tf.color = 0xffffff;
			
			_enterTf.setTextFormat(tf);
			_enterTf.embedFonts = true;
			_enterTf.selectable = true;
			
			_enterTf.width = CEngine.mainStage.stage.stageWidth - 105; 
			_enterTf.height = 25;
			_enterTf.x = 100;		
			_enterTf.type = TextFieldType.INPUT;
			_enterTf.y = _logTf.height + 5;
						
			addChild(_enterTf);
			
		}
	}
}