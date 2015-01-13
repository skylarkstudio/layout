package layout;


import flash.events.Event;
import flash.geom.Point;


/**
 * @author Joshua Granick
 */
class LayoutGroup extends LayoutItem {
	
	
	public var clampHeight:Bool;
	public var clampWidth:Bool;
	public var height (get, set):Float;
	public var initHeight (default, null):Float;
	public var initScale (default, null):Float;
	public var initWidth (default, null):Float;
	public var items:Array<LayoutItem>;
	public var pixelScale (get, set):Float;
	public var width (get, set):Float;
	public var x (get, set):Float;
	public var y (get, set):Float;
	
	private var itemConfigureHorizontal:Array <Bool>;
	private var itemConfigureVertical:Array <Bool>;
	
	private var _height:Float;
	private var _pixelScale:Float;
	private var _width:Float;
	private var _x:Float;
	private var _y:Float;
	
	
	public function new (initWidth:Float = 0, initHeight:Float = 0, initScale:Float = 1, horizontalLayout:LayoutType = null, verticalLayout:LayoutType = null, rigidHorizontal:Bool = true, rigidVertical:Bool = true) {
		
		this.initWidth = initWidth;
		this.initHeight = initHeight;
		this.initScale = initScale;
		
		if (horizontalLayout == null) {
			
			horizontalLayout = LayoutType.NONE;
			
		}
		
		if (verticalLayout == null) {
			
			verticalLayout = LayoutType.NONE;
			
		}
		
		super (this, horizontalLayout, verticalLayout, rigidHorizontal, rigidVertical);
		
		_x = 0;
		_y = 0;
		
		resize (this.initWidth, this.initHeight);
		
	}
	
	
	public function addItem (item:LayoutItem, autoConfigureHorizontal:Bool = true, autoConfigureVertical:Bool = true, updateSize:Bool = true):Void {
		
		configureItem (item, autoConfigureHorizontal, autoConfigureVertical);
		
		items.push (item);
		itemConfigureHorizontal.push (autoConfigureHorizontal);
		itemConfigureVertical.push (autoConfigureVertical);
		
		if (updateSize) {
			
			refreshSize ();
			
		}
		
	}
	
	
	private function configureItem (item:LayoutItem, autoConfigureHorizontal:Bool, autoConfigureVertical:Bool):Void {
		
		if (autoConfigureHorizontal) {
			
			switch (item.horizontalLayout) {
				
				case LayoutType.CENTER:
					
					var horizontalOffset = item.objectX - (initWidth / 2 - item.objectWidth / 2) - _x;
					
					if (horizontalOffset > 0) {
						
						item.marginLeft = horizontalOffset;
						
					} else {
						
						item.marginRight = Math.abs (horizontalOffset);
						
					}
				
				case LayoutType.LEFT:
					
					item.marginLeft = item.objectX - _x;
				
				case LayoutType.RIGHT:
					
					item.marginRight = initWidth - item.objectX - item.objectWidth - _x;
				
				case LayoutType.STRETCH:
					
					item.marginLeft = item.objectX - _x;
					item.marginRight = initWidth - item.objectX - item.objectWidth - _x;
					
					if (item.rigidHorizontal && item.minWidth == null) {
						
						item.minWidth = item.objectWidth;
						
					}
				
				default:
				
			}
			
		}
		
		if (autoConfigureVertical) {
			
			switch (item.verticalLayout) {
				
				case LayoutType.BOTTOM:
					
					item.marginBottom = initHeight - item.objectY - item.objectHeight - _y;
				
				case LayoutType.CENTER:
					
					var verticalOffset = item.objectY - (initHeight / 2 - item.objectHeight / 2) - _y;
					
					if (verticalOffset > 0) {
						
						item.marginTop = verticalOffset;
						
					} else {
						
						item.marginBottom = Math.abs (verticalOffset);
						
					}
				
				case LayoutType.STRETCH:
					
					item.marginTop = item.objectY - _y;
					item.marginBottom = initHeight - item.objectY - item.objectHeight - _y;
					
					if (item.rigidVertical && item.minHeight == null) {
						
						item.minHeight = item.objectHeight;
						
					}
				
				case LayoutType.TOP:
					
					item.marginTop = item.objectY - _y;
				
				default:
				
			}
			
		}
		
	}
	
	
	private override function initialize ():Void {
		
		items = new Array <LayoutItem> ();
		itemConfigureHorizontal = new Array <Bool> ();
		itemConfigureVertical = new Array <Bool> ();
		
		super.initialize ();
		
	}
	
	
	public function layoutItems ():Void {
		
		var minWidth = ifDefined (minWidth, 0);
		var minHeight = ifDefined (minHeight, 0);
		
		for (item in items) {
			
			item.layoutItem (this);
			
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
		
		var newWidth = width;
		var newHeight = height;
		
		if (newWidth < minWidth) {
			
			newWidth = minWidth;
			
		}
		
		if (newHeight < minHeight) {
			
			newHeight = minHeight;
			
		}
		
		if (clampWidth && newWidth > initWidth) {
			
			newWidth = initWidth;
			
		}
		
		if (clampHeight && newHeight > initHeight) {
			
			newHeight = initHeight;
			
		}
		
		if (newWidth != width || newHeight != height) {
			
			resize (newWidth, newHeight);
			
		}
		
	}
	
	
	private function refreshSize ():Void {
		
		if (items.length > 0) {
			
			var beginning = new Point (Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY);
			var end = new Point (Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY);
			
			for (item in items) {
				
				if (item.horizontalLayout != LayoutType.NONE) {
					
					if (item.objectX < beginning.x) {
						
						beginning.x = item.objectX;
						
					}
					
					if (item.objectX + item.objectWidth > end.x) {
						
						end.x = item.objectX + item.objectWidth;
						
					}
					
				}
				
				if (item.verticalLayout != LayoutType.NONE) {
					
					if (item.objectY < beginning.y) {
						
						beginning.y = item.objectY;
						
					}
					
					if (item.objectY + item.objectHeight > end.y) {
						
						end.y = item.objectY + item.objectHeight;
						
					}
					
				}
				
			}
			
			_x = beginning.x;
			_y = beginning.y;
			_width = initWidth = end.x - beginning.x;
			_height = initHeight = end.y - beginning.y;
			
			for (i in 0...items.length) {
				
				configureItem (items[i], itemConfigureHorizontal[i], itemConfigureVertical[i]);
				
			}
			
		}
		
	}
	
	
	public function resize (width:Float, height:Float):Void {
		
		var cacheWidth = this.width;
		var cacheHeight = this.height;
		
		_width = width;
		_height = height;
		
		if (items.length > 0) {
			
			layoutItems ();
			
		} else {
			
			initWidth = width;
			initHeight = height;
			
		}
		
		if (this.width != cacheWidth || this.height != cacheHeight) {
			
			dispatchEvent (new Event (Event.RESIZE));
			
		}
		
	}
	
	
	public function scale (scale:Float):Void {
		
		_pixelScale = scale;
		
		if (items.length > 0) {
			
			layoutItems ();
			
		} else {
			
			initScale = _pixelScale;
			
		}
		
	}
	
	
	public function setInitSize (width:Float, height:Float):Void {
		
		initWidth = width;
		initHeight = height;
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private function get_height ():Float {
		
		return _height;
		
	}
	
	
	private function set_height (value:Float):Float {
		
		resize (_width, value);
		
		return _height;
		
	}
	
	
	private function get_pixelScale ():Float {
		
		return _pixelScale;
		
	}
	
	
	private function set_pixelScale (value:Float):Float {
		
		scale (value);
		
		return _pixelScale;
		
	}
	
	
	private function get_width ():Float {
		
		return _width;
		
	}
	
	
	private function set_width (value:Float):Float {
		
		resize (value, _height);
		
		return _width;
		
	}
	
	
	private function get_x ():Float {
		
		return _x;
		
	}
	
	
	private function set_x (value:Float):Float {
		
		_x = value;
		
		layoutItems ();
		
		return _x;
		
	}
	
	
	private function get_y ():Float {
		
		return _y;
		
	}
	
	
	private function set_y (value:Float):Float {
		
		_y = value;
		
		layoutItems ();
		
		return _y;
		
	}
	
	
}