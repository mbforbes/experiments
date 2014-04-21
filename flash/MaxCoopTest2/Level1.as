package {
    import flash.geom.Rectangle;
    import flash.media.Sound;
    import flash.net.URLRequest;

    public class Level1 extends A_Level {
	
	// TODO there's gotta be a better way of doing this than this...
	[Embed(source="Blimp1.png")]
	private var BlimpImage:Class;

	[Embed(source="Cloud1.png")]
	private var CloudImage:Class;

	[Embed(source="Cyprus1.png")]
	private var Cyprus1Image:Class;

	[Embed(source="Cyprus2.png")]
	private var Cyprus2Image:Class;

	[Embed(source="TuscanHills.png")]
	private var TuscanHillsImage:Class;

	[Embed(source="TuscanSky.png")]
	private var TuscanSkyImage:Class;

	[Embed(source="bird-r.png")]
	private var BirdModelRight:Class;

	[Embed(source="bird-l.png")]
	private var BirdModelLeft:Class;
	
	protected override function init():void {
	    super.init(); // just in case ... is this good style?

	    // set music
	    music = new Sound(new URLRequest("tuscanSetting-8bit.mp3"));
	    
	    // create objects for this level
	    //TODO subclass all ... this process should be zero code (just loading xml file, say...
	    // an auto-generated XML file...)

	   var tuscanSky:A_SceneObject = new A_SceneObject(0,0);
	   tuscanSky.addChild(new TuscanSkyImage);
	   Register(tuscanSky);

	   var cloud2:A_SceneObject = new A_SceneObject(320, 110, -0.4);
	   cloud2.addChild(new CloudImage);
	   cloud2.boundary = new Rectangle(0,0,Settings.WIDTH, 450);
	   Register(cloud2);

	   var cyprus2:A_SceneObject = new A_SceneObject(188, 4);
	   cyprus2.addChild(new Cyprus2Image);
	   Register(cyprus2);

	   var blimp:A_SceneObject = new A_SceneObject(695, 325, .8);
	   blimp.addChild(new BlimpImage);
	   blimp.boundary = new Rectangle(0,0,Settings.WIDTH, 450);
	   Register(blimp);

	   var cyprus1:A_SceneObject = new A_SceneObject(26, 60);
	   cyprus1.addChild(new Cyprus1Image);
	   Register(cyprus1);

	   var tuscanHills:A_SceneObject = new A_SceneObject(0, 495);
	   tuscanHills.addChild(new TuscanHillsImage);
	   Register(tuscanHills);

	   var cloud1:A_SceneObject = new A_SceneObject(392, 74, -0.15);
	   cloud1.addChild(new CloudImage);
	   cloud1.boundary = new Rectangle(0,0,Settings.WIDTH, 450);
	   Register(cloud1);

	   var bird:Player = new Player(0, Settings.HEIGHT - 62);
	   bird.modelDictionary[Settings.PLAYER_FACING_RIGHT] = new BirdModelRight();
	   bird.modelDictionary[Settings.PLAYER_FACING_LEFT] = new BirdModelLeft();
	   bird.addChild(new BirdModelRight()); // not so elegant for default...
	   Register(bird);
       }
    }
}
