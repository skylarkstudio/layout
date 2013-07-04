package layout;


import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;


/**
 * @author Joshua Granick
 */
@:access(layout.LayoutItem)
class LayoutManager extends EventDispatcher {
	
	
	public var clampHeight (get, set):Bool;
	public var clampWidth (get, set):Bool;
	public var height (get, null):Float;
	public var initHeight (get, null):Float;
	public var initWidth (get, null):Float;
	public var minHeight (get, set):Float;
	public var minWidth (get, set):Float;
	public var width (get, null):Float;
	
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
				
				item.objectX = layoutGroup.width / 2 - item.objectWidth / 2 + item.marginLeft - item.marginRight;
			
			case LayoutType.LEFT:
				
				item.objectX = item.marginLeft;
			
			case LayoutType.RIGHT:
				
				item.objectX = layoutGroup.width - item.objectWidth - item.marginRight;
			
			case LayoutType.STRETCH:
				
				item.objectX = item.marginLeft;
				
				var stretchWidth = layoutGroup.width - item.marginLeft - item.marginRight;
				
				if (stretchWidth < 0) {
					
					stretchWidth = 0;
					
				}
				
				if (item.rigidHorizontal && item.minWidth != null && stretchWidth < item.minWidth) {
					
					item.objectWidth = item.minWidth;
					
				} else {
					
					item.objectWidth = stretchWidth;
					
				}
			
			default:
			
		}
		
		switch (item.verticalLayout) {
			
			case LayoutType.BOTTOM:
				
				item.objectY = layoutGroup.height - item.objectHeight - item.marginBottom;
			
			case LayoutType.CENTER:
				
				item.objectY = layoutGroup.height / 2 - item.objectHeight / 2 + item.marginTop - item.marginBottom;
			
			case LayoutType.STRETCH:
				
				item.objectY = item.marginTop;
				
				var stretchHeight:Float = layoutGroup.height - item.marginTop - item.marginBottom;
				
				if (stretchHeight < 0) {
					
					stretchHeight = 0;
					
				}
				
				if (item.rigidVertical && item.minHeight != null && stretchHeight < item.minHeight) {
					
					item.objectHeight = item.minHeight;
					
				} else {
					
					item.objectHeight = stretchHeight;
					
				}
			
			case LayoutType.TOP:
				
				item.objectY = item.marginTop;
			
			default:
			
		}
		
		item.objectX += layoutGroup.x;
		item.objectY += layoutGroup.y;
		
	}
	
	
	/**
	 * @private
	 */
	public static function layoutItemGroup (layoutGroup:LayoutGroup):Void {
		
		var minWidth = ifDefined (layoutGroup.minWidth, 0);
		var minHeight = ifDefined (layoutGroup.minHeight, 0);
		
		for (item in layoutGroup.items) {
			
			layoutItem (item, layoutGroup);
			
			if (item.rigidHorizontal) {
				
				var minObjectWidth = item.marginLeft + item.marginRight;
				
				if (item.minWidth != null) {
					
					minObjectWidth += item.minWidth;
					
				} else {
					
					minObjectWidth += item.objectWidth;
					
				}
				
				if (minWidth < minObjectWidth) {
					
					minWidth = minObjectWidth;
					
				}
				
			}
			
			if (item.rigidVertical) {
				
				var minObjectHeight = item.marginTop + item.marginBottom;
				
				if (item.minHeight != null) {
					
					minObjectHeight += item.minHeight;
					
				} else {
					
					minObjectHeight += item.objectHeight;
					
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
	
	
	
	
	private function get_clampHeight ():Bool {
		
		return items.clampHeight;
		
	}
	
	
	private function set_clampHeight (value:Bool):Bool {
		
		return items.clampHeight = value;
		
	}
	
	
	private function get_clampWidth ():Bool {
		
		return items.clampWidth;
		
	}
	
	
	private function set_clampWidth (value:Bool):Bool {
		
		return items.clampWidth = value;
		
	}
	
	
	private function get_height ():Float {
		
		return items.height;
		
	}
	
	
	private function get_initHeight ():Float {
		
		return items.initHeight;
		
	}
	
	
	private function get_initWidth ():Float {
		
		return items.initWidth;
		
	}
	
	
	private function get_minHeight ():Float {
		
		return items.minHeight;
		
	}
	
	
	private function set_minHeight (value:Float):Float {
		
		return items.minHeight = value;
		
	}
	
	
	private function get_minWidth ():Float {
		
		return items.minWidth;
		
	}
	
	
	private function set_minWidth (value:Float):Float {
		
		return items.minWidth = value;
		
	}
	
	
	private function get_width ():Float {
		
		return items.width;
		
	}
	
	
}