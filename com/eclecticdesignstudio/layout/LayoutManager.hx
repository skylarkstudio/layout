package com.eclecticdesignstudio.layout;


import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;


/**
 * @author Joshua Granick
 */
class LayoutManager extends EventDispatcher {
	
	
	public var clampHeight (getClampHeight, setClampHeight):Bool;
	public var clampWidth (getClampWidth, setClampWidth):Bool;
	public var height (getHeight, null):Float;
	public var initHeight (getInitHeight, null):Float;
	public var initWidth (getInitWidth, null):Float;
	public var minHeight (getMinHeight, setMinHeight):Float;
	public var minWidth (getMinWidth, setMinWidth):Float;
	public var width (getWidth, null):Float;
	
	private var items:LayoutGroup;
	
	private var _initHeight:Float;
	private var _initWidth:Float;
	
	
	public function new (initWidth:Float = 0, initHeight:Float = 0) {
		
		super ();
		
		_initWidth = initWidth;
		_initHeight = initHeight;
		
		initialize ();
		
	}
	
	
	public function addItem (item:LayoutItem, autoConfigureHorizontal:Bool = true, autoConfigureVertical:Bool = true):Void {
		
		items.addItem (item, autoConfigureHorizontal, autoConfigureVertical, false);
		
	}
	
	
	private static function ifDefined (value:Dynamic, defaultValue:Dynamic):Dynamic {
		
		if (value != null) {
			
			if (!Std.is (value, String) || (Std.is (value, String) && value != "")) {
				
				return value;
				
			}
			
		}
		
		return defaultValue;
		
	}
	
	
	private function initialize ():Void {
		
		items = new LayoutGroup (LayoutType.NONE, LayoutType.NONE, false);
		items.resize (_initWidth, _initHeight);
		
	}
	
	
	private static function layoutItem (item:LayoutItem, layoutGroup:LayoutGroup):Void {
		
		switch (item.horizontalLayout) {
			
			case LayoutType.CENTER:
				
				item.object.x = layoutGroup.width / 2 - item.object.width / 2 + item.marginLeft - item.marginRight;
			
			case LayoutType.LEFT:
				
				item.object.x = item.marginLeft;
			
			case LayoutType.RIGHT:
				
				item.object.x = layoutGroup.width - item.object.width - item.marginRight;
			
			case LayoutType.STRETCH:
				
				item.object.x = item.marginLeft;
				
				var stretchWidth:Float = layoutGroup.width - item.marginLeft - item.marginRight;
				
				if (stretchWidth < 0) {
					
					stretchWidth = 0;
					
				}
				
				if (item.rigidHorizontal && !Math.isNaN (item.minWidth) && stretchWidth < item.minWidth) {
					
					item.object.width = item.minWidth;
					
				} else {
					
					item.object.width = stretchWidth;
					
				}
			
			default:
			
		}
		
		switch (item.verticalLayout) {
			
			case LayoutType.BOTTOM:
				
				item.object.y = layoutGroup.height - item.object.height - item.marginBottom;
			
			case LayoutType.CENTER:
				
				item.object.y = layoutGroup.height / 2 - item.object.height / 2 + item.marginTop - item.marginBottom;
			
			case LayoutType.STRETCH:
				
				item.object.y = item.marginTop;
				
				var stretchHeight:Float = layoutGroup.height - item.marginTop - item.marginBottom;
				
				if (stretchHeight < 0) {
					
					stretchHeight = 0;
					
				}
				
				if (item.rigidVertical && !Math.isNaN (item.minHeight) && stretchHeight < item.minHeight) {
					
					item.object.height = item.minHeight;
					
				} else {
					
					item.object.height = stretchHeight;
					
				}
			
			case LayoutType.TOP:
				
				item.object.y = item.marginTop;
			
			default:
			
		}
		
		item.object.x += layoutGroup.x;
		item.object.y += layoutGroup.y;
		
	}
	
	
	/**
	 * @private
	 */
	public static function layoutItemGroup (layoutGroup:LayoutGroup):Void {
		
		var minWidth:Float = ifDefined (layoutGroup.minWidth, 0);
		var minHeight:Float = ifDefined (layoutGroup.minHeight, 0);
		
		for (item in layoutGroup.items) {
			
			layoutItem (item, layoutGroup);
			
			if (item.rigidHorizontal) {
				
				var minObjectWidth = item.marginLeft + item.marginRight;
				
				if (!Math.isNaN (item.minWidth)) {
					
					minObjectWidth += item.minWidth;
					
				} else {
					
					minObjectWidth += item.object.width;
					
				}
				
				if (minWidth < minObjectWidth) {
					
					minWidth = minObjectWidth;
					
				}
				
			}
			
			if (item.rigidVertical) {
				
				var minObjectHeight = item.marginTop + item.marginBottom;
				
				if (!Math.isNaN (item.minHeight)) {
					
					minObjectHeight += item.minHeight;
					
				} else {
					
					minObjectHeight += item.object.height;
					
				}
				
				if (minHeight < minObjectHeight) {
					
					minHeight = minObjectHeight;
					
				}
				
			}
			
		}
		
		var newWidth = layoutGroup.width;
		var newHeight = layoutGroup.height;
		
		if (newWidth < minWidth) {
			
			newWidth = minWidth;
			
		}
		
		if (newHeight < minHeight) {
			
			newHeight = minHeight;
			
		}
		
		if (layoutGroup.clampWidth && newWidth > layoutGroup.initWidth) {
			
			newWidth = layoutGroup.initWidth;
			
		}
		
		if (layoutGroup.clampHeight && newHeight > layoutGroup.initHeight) {
			
			newHeight = layoutGroup.initHeight;
			
		}
		
		if (newWidth != layoutGroup.width || newHeight != layoutGroup.height) {
			
			layoutGroup.resize (newWidth, newHeight);
			
		}
		
	}
	
	
	public function layoutItems ():Void {
		
		layoutItemGroup (items);
		
	}
	
	
	public function resize (width:Float, height:Float):Void {
		
		var cacheWidth = items.width;
		var cacheHeight = items.height;
		
		items.resize (width, height);
		
		if (items.width != cacheWidth || items.height != cacheHeight) {
			
			dispatchEvent (new Event (Event.RESIZE));
			
		}
		
	}
	
	
	public function setMinSize (minWidth:Float = 0, minHeight:Float = 0):Void {
		
		items.minWidth = minWidth;
		items.minHeight = minHeight;
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private function getClampHeight ():Bool {
		
		return items.clampHeight;
		
	}
	
	
	private function setClampHeight (value:Bool):Bool {
		
		return items.clampHeight = value;
		
	}
	
	
	private function getClampWidth ():Bool {
		
		return items.clampWidth;
		
	}
	
	
	private function setClampWidth (value:Bool):Bool {
		
		return items.clampWidth = value;
		
	}
	
	
	private function getHeight ():Float {
		
		return items.height;
		
	}
	
	
	private function getInitHeight ():Float {
		
		return items.initHeight;
		
	}
	
	
	private function getInitWidth ():Float {
		
		return items.initWidth;
		
	}
	
	
	private function getMinHeight ():Float {
		
		return items.minHeight;
		
	}
	
	
	private function setMinHeight (value:Float):Float {
		
		return items.minHeight = value;
		
	}
	
	
	private function getMinWidth ():Float {
		
		return items.minWidth;
		
	}
	
	
	private function setMinWidth (value:Float):Float {
		
		return items.minWidth = value;
		
	}
	
	
	private function getWidth ():Float {
		
		return items.width;
		
	}
	
	
}