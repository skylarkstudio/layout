package layout;


import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;

@:access(layout.LayoutItem)


/**
 * @author Joshua Granick
 */
class LayoutManager {
	
	
	public static var clampHeight (get, set):Bool;
	public static var clampWidth (get, set):Bool;
	public static var height (get, null):Float;
	public static var initHeight (get, null):Float;
	public static var initScale (get, null):Float;
	public static var initWidth (get, null):Float;
	public static var minHeight (get, set):Float;
	public static var minWidth (get, set):Float;
	public static var pixelScale (get, set):Float;
	public static var width (get, null):Float;
	
	private static var eventDispatcher:EventDispatcher;
	private static var initialized = false;
	private static var items:LayoutGroup;
	
	private var _initHeight:Float;
	private var _initWidth:Float;
	
	
	public static function addEventListener (type:String, listener:Dynamic, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void {
		
		initialize ();
		
		eventDispatcher.addEventListener (type, listener, useCapture, priority, useWeakReference);
		
	}
	
	
	public static function addItem (item:LayoutItem, autoConfigureHorizontal:Bool = true, autoConfigureVertical:Bool = true):Void {
		
		initialize ();
		
		items.addItem (item, autoConfigureHorizontal, autoConfigureVertical, false);
		
	}
	
	
	public static function dispatchEvent (event:Event):Bool {
		
		initialize ();
		
		return eventDispatcher.dispatchEvent (event);
		
	}
	
	
	public static function hasEventListener (type:String):Bool {
		
		initialize ();
		
		return eventDispatcher.hasEventListener (type);
		
	}
	
	
	private static function initialize ():Void {
		
		if (!initialized) {
			
			initialized = true;
			
			eventDispatcher = new EventDispatcher ();
			
			items = new LayoutGroup (0, 0, 1, NONE, NONE, false, false);
			items.addEventListener (Event.RESIZE, items_onResize);
			
		}
		
	}
	
	
	public static function layoutItems ():Void {
		
		initialize ();
		
		items.layoutItems ();
		
	}
	
	
	public static function removeEventListener (type:String, listener:Dynamic, capture:Bool = false):Void {
		
		initialize ();
		
		eventDispatcher.removeEventListener (type, listener, capture);
		
	}
	
	
	public static function resize (width:Float, height:Float):Void {
		
		initialize ();
		
		items.resize (width, height);
		
	}
	
	
	public static function scale (scale:Float):Void {
		
		items.scale (scale);
		
	}
	
	
	public static function setInitSize (width:Float, height:Float):Void {
		
		initialize ();
		
		items.setInitSize (width, height);
		
	}
	
	
	public static function setMinSize (minWidth:Float = 0, minHeight:Float = 0):Void {
		
		initialize ();
		
		items.setMinSize (minWidth, minHeight);
		
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private static function items_onResize (event:Event):Void {
		
		eventDispatcher.dispatchEvent (new Event (Event.RESIZE)); 
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private static function get_clampHeight ():Bool {
		
		initialize ();
		
		return items.clampHeight;
		
	}
	
	
	private static function set_clampHeight (value:Bool):Bool {
		
		initialize ();
		
		return items.clampHeight = value;
		
	}
	
	
	private static function get_clampWidth ():Bool {
		
		initialize ();
		
		return items.clampWidth;
		
	}
	
	
	private static function set_clampWidth (value:Bool):Bool {
		
		initialize ();
		
		return items.clampWidth = value;
		
	}
	
	
	private static function get_height ():Float {
		
		initialize ();
		
		return items.height;
		
	}
	
	
	private static function get_initHeight ():Float {
		
		initialize ();
		
		return items.initHeight;
		
	}
	
	
	private static function get_initScale ():Float {
		
		initialize ();
		
		return items.initScale;
		
	}
	
	
	private static function get_initWidth ():Float {
		
		initialize ();
		
		return items.initWidth;
		
	}
	
	
	private static function get_minHeight ():Float {
		
		initialize ();
		
		return items.minHeight;
		
	}
	
	
	private static function set_minHeight (value:Float):Float {
		
		initialize ();
		
		return items.minHeight = value;
		
	}
	
	
	private static function get_minWidth ():Float {
		
		initialize ();
		
		return items.minWidth;
		
	}
	
	
	private static function set_minWidth (value:Float):Float {
		
		initialize ();
		
		return items.minWidth = value;
		
	}
	
	
	private static function get_pixelScale ():Float {
		
		initialize ();
		
		return items.pixelScale;
		
	}
	
	
	private static function set_pixelScale (value:Float):Float {
		
		initialize ();
		
		return items.pixelScale = value;
		
	}
	
	
	private static function get_width ():Float {
		
		initialize ();
		
		return items.width;
		
	}
	
	
}