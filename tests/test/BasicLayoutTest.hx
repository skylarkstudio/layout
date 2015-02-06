package;


import layout.LayoutGroup;
import layout.LayoutItem;
import massive.munit.Assert;


class BasicLayoutTest {
	
	
	public var background:DisplayObject;
	public var logo:DisplayObject;
	public var sidebar:DisplayObject;
	public var footer:DisplayObject;
	
	private var logoX = 10;
	private var logoY = 10;
	private var logoWidth = 40;
	private var logoHeight = 25;
	private var sidebarOffsetX = 60;
	private var sidebarWidth = 60;
	private var sidebarOffsetHeight = 40;
	private var footerOffsetY = 40;
	private var footerHeight = 40;
	
	
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
	
	
	@Test public function testLayoutGroup ():Void {
		
		var layoutGroup = new LayoutGroup (200, 200);
		layoutGroup.addItem (new LayoutItem (background, STRETCH, STRETCH));
		layoutGroup.addItem (new LayoutItem (logo, LEFT, TOP));
		layoutGroup.addItem (new LayoutItem (sidebar, RIGHT, STRETCH));
		layoutGroup.addItem (new LayoutItem (footer, STRETCH, BOTTOM));
		
		trace ("1");
		
		checkObjects (200, 200);
		
		layoutGroup.resize (200, 200);
		
		trace ("2");
		
		checkObjects (200, 200);
		
		layoutGroup.resize (300, 240);
		
		trace ("3");
		
		checkObjects (300, 240);
		
		layoutGroup.resize (1200, 1370);
		
		trace ("4");
		
		checkObjects (1200, 1370);
		
		layoutGroup.resize (1500, 1200);
		
		trace ("5");
		
		checkObjects (1500, 1200);
		
	}
	
	
	private function checkObjects (width:Float, height:Float):Void {
		
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