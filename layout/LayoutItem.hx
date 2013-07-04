package layout;


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
	public var minHeight:Null<Float>;
	public var minWidth:Null<Float>;
	public var object:Dynamic;
	public var rigidHorizontal:Bool;
	public var rigidVertical:Bool;
	public var verticalLayout:LayoutType;
	
	private var objectHeight (get, set):Float;
	private var objectWidth (get, set):Float;
	private var objectX (get, set):Float;
	private var objectY (get, set):Float;
	
	
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
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private #if (!neko && !js) inline #end function get_objectHeight ():Float {
		
		#if (neko || js)
		
		if (Reflect.hasField (object, "height")) {
			
			return Reflect.field (object, "height");
			
		} else {
			
			return Reflect.getProperty (object, "height");
			
		}
		
		#else
		
		return object.height;
		
		#end
		
	}
	
	
	private #if (!neko && !js) inline #end function set_objectHeight (value:Float):Float {
		
		#if (neko || js)
		
		if (Reflect.hasField (object, "height")) {
			
			Reflect.setField (object, "height", value);
			
		} else {
			
			Reflect.setProperty (object, "height", value);
			
		}
		
		return value;
		
		#else
		
		return object.height = value;
		
		#end
		
	}
	
	
	private #if (!neko && !js) inline #end function get_objectWidth ():Float {
		
		#if (neko || js)
		
		if (Reflect.hasField (object, "width")) {
			
			return Reflect.field (object, "width");
			
		} else {
			
			return Reflect.getProperty (object, "width");
			
		}
		
		#else
		
		return object.width;
		
		#end
		
	}
	
	
	private #if (!neko && !js) inline #end function set_objectWidth (value:Float):Float {
		
		#if (neko || js)
		
		if (Reflect.hasField (object, "width")) {
			
			Reflect.setField (object, "width", value);
			
		} else {
			
			Reflect.setProperty (object, "width", value);
			
		}
		
		return value;
		
		#else
		
		return object.width = value;
		
		#end
		
	}
	
	
	private #if (!neko && !js) inline #end function get_objectX ():Float {
		
		#if (neko || js)
		
		if (Reflect.hasField (object, "x")) {
			
			return Reflect.field (object, "x");
			
		} else {
			
			return Reflect.getProperty (object, "x");
			
		}
		
		#else
		
		return object.x;
		
		#end
		
	}
	
	
	private #if (!neko && !js) inline #end function set_objectX (value:Float):Float {
		
		#if (neko || js)
		
		if (Reflect.hasField (object, "x")) {
			
			Reflect.setField (object, "x", value);
			
		} else {
			
			Reflect.setProperty (object, "x", value);
			
		}
		
		return value;
		
		#else
		
		return object.x = value;
		
		#end
		
	}
	
	
	private #if (!neko && !js) inline #end function get_objectY ():Float {
		
		#if (neko || js)
		
		if (Reflect.hasField (object, "y")) {
			
			return Reflect.field (object, "y");
			
		} else {
			
			return Reflect.getProperty (object, "y");
			
		}
		
		#else
		
		return object.y;
		
		#end
		
	}
	
	
	private #if (!neko && !js) inline #end function set_objectY (value:Float):Float {
		
		#if (neko || js)
		
		if (Reflect.hasField (object, "y")) {
			
			Reflect.setField (object, "y", value);
			
		} else {
			
			Reflect.setProperty (object, "y", value);
			
		}
		
		return value;
		
		#else
		
		return object.y = value;
		
		#end
		
	}
	
	
}