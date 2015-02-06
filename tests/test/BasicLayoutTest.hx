package;


import layout.Layout;
import layout.LayoutItem;
import massive.munit.Assert;


class BasicLayoutTest {
	
	
	public static var background:DisplayObject;
	public static var logo:DisplayObject;
	public static var sidebar:DisplayObject;
	public static var footer:DisplayObject;
	
	private static var logoX = 10;
	private static var logoY = 10;
	private static var logoWidth = 40;
	private static var logoHeight = 25;
	private static var sidebarOffsetX = 60;
	private static var sidebarWidth = 60;
	private static var sidebarOffsetHeight = 40;
	private static var footerOffsetY = 40;
	private static var footerHeight = 40;
	
	
	@Before public function setup ():Void {
		
		var width = 200;
		var height = 200;
		
		background = new DisplayObject ();
		background.x = 0;
		background.y = 0;
		background.width = width;
		background.height = height;
		
		logo = new DisplayObject ();
		logo.x = logoX;
		logo.y = logoY;
		logo.width = logoWidth;
		logo.height = logoHeight;
		
		sidebar = new DisplayObject ();
		sidebar.x = width - sidebarOffsetX;
		sidebar.y = 0;
		sidebar.width = sidebarWidth;
		sidebar.height = height - sidebarOffsetHeight;
		
		footer = new DisplayObject ();
		footer.x = 0;
		footer.y = height - footerOffsetY;
		footer.width = width;
		footer.height = footerHeight;
		
	}
	
	
	@Test public function testInitSize ():Void {
		
		// Set an exact layout size
		
		var layout = new Layout (200, 200);
		layout.addItem (new LayoutItem (background, STRETCH, STRETCH));
		layout.addItem (new LayoutItem (logo, LEFT, TOP));
		layout.addItem (new LayoutItem (sidebar, RIGHT, STRETCH));
		layout.addItem (new LayoutItem (footer, STRETCH, BOTTOM));
		checkObjects (200, 200);
		
		layout.resize (200, 200);
		checkObjects (200, 200);
		
		layout.resize (300, 240);
		checkObjects (300, 240);
		
		layout.resize (1200, 1370);
		checkObjects (1200, 1370);
		
		layout.resize (1500, 1200);
		checkObjects (1500, 1200);
		
		layout.resize (220, 100);
		checkObjects (220, 100);
		
		layout.resize (100, 220);
		checkObjects (100, 220);
		
		layout.resize (10, 10);
		checkObjects (10, 10);
		
	}
	
	
	@Test public function testNoInitSize ():Void {
		
		// Get the init layout size automatically (based on the size of the objects added before resizing)
		
		var layout = new Layout ();
		layout.addItem (new LayoutItem (background, STRETCH, STRETCH));
		layout.addItem (new LayoutItem (logo, LEFT, TOP));
		layout.addItem (new LayoutItem (sidebar, RIGHT, STRETCH));
		layout.addItem (new LayoutItem (footer, STRETCH, BOTTOM));
		checkObjects (200, 200);
		
		layout.resize (200, 200);
		checkObjects (200, 200);
		
		layout.resize (300, 240);
		checkObjects (300, 240);
		
		layout.resize (1200, 1370);
		checkObjects (1200, 1370);
		
		layout.resize (1500, 1200);
		checkObjects (1500, 1200);
		
		layout.resize (220, 100);
		checkObjects (220, 100);
		
		layout.resize (100, 220);
		checkObjects (100, 220);
		
		layout.resize (10, 10);
		checkObjects (10, 10);
		
	}
	
	
	private inline function checkObjects (width:Float, height:Float):Void {
		
		// Items are rigid horizontal/vertical by default, so the layout should not allow smaller sizes than 200 x 200 (background size)
		
		if (width < 200) width = 200;
		if (height < 200) height = 200;
		
		Assert.areEqual (0, background.x);
		Assert.areEqual (0, background.y);
		Assert.areEqual (width, background.width);
		Assert.areEqual (height, background.height);
		
		Assert.areEqual (logoX, logo.x);
		Assert.areEqual (logoY, logo.y);
		Assert.areEqual (logoWidth, logo.width);
		Assert.areEqual (logoHeight, logo.height);
		
		Assert.areEqual (width - sidebarOffsetX, sidebar.x);
		Assert.areEqual (0, sidebar.y);
		Assert.areEqual (sidebarWidth, sidebar.width);
		Assert.areEqual (height - sidebarOffsetHeight, sidebar.height);
		
		Assert.areEqual (0, footer.x);
		Assert.areEqual (height - footerOffsetY, footer.y);
		Assert.areEqual (width, footer.width);
		Assert.areEqual (footerHeight, footer.height);
		
	}
	
	
}


class DisplayObject {
	
	
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	
	
	public function new () {
		
		
		
	}
	
	
}