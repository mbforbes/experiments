package {
    
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;
    import Settings;

    // TODO: do function passing for the following
    // - behavor (advect motion? or just move?)
    //     - external forces (apply gravity function, etc)
    //     - collision actions (depending on what it collides with)
    // - boundary detection (save as var and use for tests)
    
    // notes on TODOs:
    // passing in functions with params to be saved for behavior allows 
    // reusing of common behavior code and modifying universally throughout...

    /*
     * Abstract Class
     * 
     * A scene object is something in the background of the scene.
     * 
     * @author Maxwell Forbes
     */
    public class A_SceneObject extends Sprite {
	// This is set externally and used on each Update() for collision
	// detection. It is cleared after each Update().
	public var collidedObjects:Array;

	// This can be set externally and is used for altering the object's bounds.
	public var boundary:Rectangle=Settings.GAME_BOUNDARY;

	// This can be set externally and is used for wrapping on out-of-boundary.
	public var boundaryBehavior:String=Settings.BOUNDARY_WARP_SMOOTH_RANDOM;
	
	// This is set externally to decide whether this gets input sent from the user
	public var getsKeyboardInput:Boolean=false;

	protected var vx:Number;
	protected var vy:Number;
	protected var ax:Number;
	protected var ay:Number;

	public function A_SceneObject(
	    xStart:Number=0,
	    yStart:Number=0,
	    vxStart:Number=0,
	    vyStart:Number=0,
	    axStart:Number=0,
	    ayStart:Number=0)
	{
	    x = xStart;
	    y = yStart;
	    vx = vxStart;
	    vy = vyStart;
	    ax = axStart;
	    ay = ayStart;
	    collidedObjects = new Array();
	}

	public function Destroy():void {
	    // deregister any handlers, do any events, do any cleanup here...
	}

	// called every frame
	public function Update():void {
	    // get forces --> acceleration
	    getForces();
	    
	    // advect motion
	    vx += ax;
	    vy += ay;
	    x += vx;
	    y += vy;

	    // apply friction
	    applyFriction();

	    // deal with collisions
	    dealWithCollisions();

	    // deal with boundaries
	    boundaryDetectionDispatch();
	}


	// subclasses override to get input
	public function receiveKeyDown(event:KeyboardEvent):void {

	}

	public function receiveKeyUp(event:KeyboardEvent):void {

	}

	// subclasses override to generate forces
	protected function getForces():void {
	    ax = 0;
	    ay = 0;
	}

	// subclasses override to apply friction
	protected function applyFriction():void {

	}

	// after call, collidedObjects is empty
	protected function dealWithCollisions():void {
	    // correct based on collisions with any ojbects here
	    for (var i:uint = 0; i < collidedObjects.length; i++) {
		collidedObjects.pop();
		// do something
	    }
	}

	protected function boundaryDetectionDispatch():void {
	    switch (boundaryBehavior) {
		case Settings.BOUNDARY_WARP:
		boundaryDetectionWarp();
		break;

		case Settings.BOUNDARY_WARP_SMOOTH:
		boundaryDetectionWarpSmooth();
		break;

		case Settings.BOUNDARY_WARP_SMOOTH_RANDOM:
		boundaryDetectionWarpSmoothRandom();
		break;

		case Settings.BOUNDARY_STOP:
		boundaryDetectionStop();
		break;
	    }
	}

	// boundary detection: warp
	// - top = nothing
	// - bottom = stop
	// - left = wrap to right
	// - right = wrap to left
	protected function boundaryDetectionWarp():void {
	    if (y + height > boundary.bottom) {
		//stop
		y = boundary.bottom - height;
		ay = 0;
		vy = 0;
	    }
	    if (x + width < boundary.left) {
		// wrap to right
		x = boundary.right - width;
	    }
	    if (x > boundary.right) {
		// wrap to left
		x = boundary.left;
	    }
	}

	// boundary detection: warp smooth
	// - top = nothing
	// - bottom = stop
	// - left = wrap to right smoothly
	// - right = wrap to left smoothly
	protected function boundaryDetectionWarpSmooth():void {
	    if (y + height > boundary.bottom) {
		//stop
		y = boundary.bottom - height;
		ay = 0;
		vy = 0;
	    }
	    if (x + width < boundary.left) {
		// wrap to right
		x = boundary.right;
	    }
	    if (x > boundary.right) {
		// wrap to left
		x = boundary.left - width;
	    }
	}

	// boundary detection: warp smooth
	// - top = nothing
	// - bottom = stop
	// - left = wrap to right smoothly, y picked randomly in available area
	// - right = wrap to left smoothly, y picked randomly in available area
	protected function boundaryDetectionWarpSmoothRandom():void {
	    if (y + height > boundary.bottom) {
		//stop
		y = boundary.bottom - height;
		ay = 0;
		vy = 0;
	    }
	    if (x + width < boundary.left) {
		// wrap to right, y random
		x = boundary.right;
		y = boundary.top + Math.random() * boundary.height;
	    }
	    if (x > boundary.right) {
		// wrap to left, y random
		x = boundary.left - width;
		y = boundary.top + Math.random() * boundary.height;
	    }
	}

	// boundary detection: stop
	// - top = stop
	// - bottom = stop
	// - left = stop
	// - right = stop
	protected function boundaryDetectionStop():void {
	    if (y + height > boundary.bottom) {
		//stop
		y = boundary.bottom - height;
		ay = 0;
		vy = 0;
	    }
	    if (x < boundary.left) {
		// stop
		x = boundary.left;
		ax = 0;
		vx = 0;
	    }
	    if (x + width > boundary.right) {
		// stop
		x = boundary.right - width;
		ax = 0;
		vx = 0;
	    }
	}
    }
}
