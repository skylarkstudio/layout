package com.eclecticdesignstudio.layout;


import flash.display.DisplayObject;


/**
 * @author Joshua Granick
 */
class LayoutItem {
	
	
	public var horizontalLayout:LayoutType;
	public var marginLeft:Float;
	public var marginRight:Float;
	public var marginTop:Float;
	public var marginBottom:Float;
	public var minHeight:Float;
	public var minWidth:Float;
	public var object:Dynamic;
	public var rigidHorizontal:Bool;
	public var rigidVertical:Bool;
	public var verticalLayout:LayoutType;
	
	
	public function new (object:Dynamic, horizontalLayout:LayoutType = null, verticalLayout:LayoutType = null, rigidHorizontal:Bool = true, rigidVertical:Bool = true) {
		
		if (horizontalLayout == null) {
			
			horizontalLayout = LayoutType.LEFT;
			
		}
		
		if (verticalLayout == null) {
			
			verticalLayout = LayoutType.TOP;
			
		}
		
		this.object = object;
		this.horizontalLayout = horizontalLayout;
		this.verticalLayout = verticalLayout;
		this.rigidHorizontal = rigidHorizontal;
		this.rigidVertical = rigidVertical;
		
		initialize ();
		
	}
	
	
	private function initialize ():Void {
		
		setMargins ();
		
	}
	
	
	public function setMargins (marginTop:Float = 0, marginRight:Float = 0, marginBottom:Float = 0, marginLeft:Float = 0):Void {
		
		this.marginTop = marginTop;
		this.marginRight = marginRight;
		this.marginBottom = marginBottom;
		this.marginLeft = marginLeft;
		
	}
	
	
	public function setMinSize (minWidth:Float = 0, minHeight:Float = 0):Void {
		
		this.minWidth = minWidth;
		this.minHeight = minHeight;
		
	}
	
	
}