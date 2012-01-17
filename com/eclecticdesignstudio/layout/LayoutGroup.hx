package com.eclecticdesignstudio.layout;


import flash.geom.Point;


/**
 * @author Joshua Granick
 */
class LayoutGroup extends LayoutItem {
	
	
	public var clampHeight:Bool;
	public var clampWidth:Bool;
	public var height (getHeight, setHeight):Float;
	public var initHeight (getInitHeight, null):Float;
	public var initWidth (getInitWidth, null):Float;
	public var items:Array <LayoutItem>;
	public var width (getWidth, setWidth):Float;
	public var x (getX, setX):Float;
	public var y (getY, setY):Float;
	
	private var itemConfigureHorizontal:Array <Bool>;
	private var itemConfigureVertical:Array <Bool>;
	
	private var _height:Float;
	private var _initHeight:Float;
	private var _initWidth:Float;
	private var _width:Float;
	private var _x:Float;
	private var _y:Float;
	
	
	public function new (horizontalLayout:LayoutType = null, verticalLayout:LayoutType = null, rigidHorizontal:Bool = true, rigidVertical:Bool = true) {
		
		if (horizontalLayout == null) {
			
			horizontalLayout = LayoutType.NONE;
			
		}
		
		if (verticalLayout == null) {
			
			verticalLayout = LayoutType.NONE;
			
		}
		
		super (this, horizontalLayout, verticalLayout, rigidHorizontal, rigidVertical);
		
		_x = 0;
		_y = 0;
		
		resize (0, 0);
		
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
					
					var horizontalOffset:Float = item.object.x - (_initWidth / 2 - item.object.width / 2) - _x;
					
					if (horizontalOffset > 0) {
						
						item.marginLeft = horizontalOffset;
						
					} else {
						
						item.marginRight = Math.abs (horizontalOffset);
						
					}
				
				case LayoutType.LEFT:
					
					item.marginLeft = item.object.x - _x;
				
				case LayoutType.RIGHT:
					
					item.marginRight = _initWidth - item.object.x - item.object.width - _x;
				
				case LayoutType.STRETCH:
					
					item.marginLeft = item.object.x - _x;
					item.marginRight = _initWidth - item.object.x - item.object.width - _x;
					
					if (item.rigidHorizontal && Math.isNaN (item.minWidth)) {
						
						item.minWidth = item.object.width;
						
					}
				
				default:
				
			}
			
		}
		
		if (autoConfigureVertical) {
			
			switch (item.verticalLayout) {
				
				case LayoutType.BOTTOM:
					
					item.marginBottom = _initHeight - item.object.y - item.object.height - _y;
				
				case LayoutType.CENTER:
					
					var verticalOffset:Float = item.object.y - (_initHeight / 2 - item.object.height / 2) - _y;
					
					if (verticalOffset > 0) {
						
						item.marginTop = verticalOffset;
						
					} else {
						
						item.marginBottom = Math.abs (verticalOffset);
						
					}
				
				case LayoutType.STRETCH:
					
					item.marginTop = item.object.y - _y;
					item.marginBottom = _initHeight - item.object.y - item.object.height - _y;
					
					if (item.rigidVertical && Math.isNaN (item.minHeight)) {
						
						item.minHeight = item.object.height;
						
					}
				
				case LayoutType.TOP:
					
					item.marginTop = item.object.y - _y;
				
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
	
	
	private function refreshSize ():Void {
		
		if (items.length > 0) {
			
			var beginning = new Point (Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY);
			var end = new Point (Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY);
			
			for (item in items) {
				
				if (item.horizontalLayout != LayoutType.NONE) {
					
					if (item.object.x < beginning.x) {
						
						beginning.x = item.object.x;
						
					}
					
					if (item.object.x + item.object.width > end.x) {
						
						end.x = item.object.x + item.object.width;
						
					}
					
				}
				
				if (item.verticalLayout != LayoutType.NONE) {
					
					if (item.object.y < beginning.y) {
						
						beginning.y = item.object.y;
						
					}
					
					if (item.object.y + item.object.height > end.y) {
						
						end.y = item.object.y + item.object.height;
						
					}
					
				}
				
			}
			
			_x = beginning.x;
			_y = beginning.y;
			_width = _initWidth = end.x - beginning.x;
			_height = _initHeight = end.y - beginning.y;
			
			for (i in 0...items.length) {
				
				configureItem (items[i], itemConfigureHorizontal[i], itemConfigureVertical[i]);
				
			}
			
		}
		
	}
	
	
	public function resize (width:Float, height:Float):Void {
		
		_width = width;
		_height = height;
		
		if (items.length > 0) {
			
			LayoutManager.layoutItemGroup (this);
			
		} else {
			
			_initWidth = width;
			_initHeight = height;
			
		}
		
	}
	
	
	public function setInitSize (width:Float, height:Float):Void {
		
		_initWidth = width;
		_initHeight = height;
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private function getHeight ():Float {
		
		return _height;
		
	}
	
	
	private function setHeight (value:Float):Float {
		
		resize (_width, value);
		
		return _height;
		
	}
	
	
	private function getInitHeight ():Float {
		
		return _initHeight;
		
	}
	
	
	private function getInitWidth ():Float {
		
		return _initWidth;
		
	}
	
	
	private function getWidth ():Float {
		
		return _width;
		
	}
	
	
	private function setWidth (value:Float):Float {
		
		resize (value, _height);
		
		return _width;
		
	}
	
	
	private function getX ():Float {
		
		return _x;
		
	}
	
	
	private function setX (value:Float):Float {
		
		_x = value;
		
		LayoutManager.layoutItemGroup (this);
		
		return _x;
		
	}
	
	
	private function getY ():Float {
		
		return _y;
		
	}
	
	
	private function setY (value:Float):Float {
		
		_y = value;
		
		LayoutManager.layoutItemGroup (this);
		
		return _y;
		
	}
	
	
}