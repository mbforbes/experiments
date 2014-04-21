package {

    import flash.display.Sprite;
    import flash.geom.Rectangle;

    /*
     * Abstract Class
     * 
     * A scene object is something in the background of the scene.
     * 
     * @author Maxwell Forbes
     */
    public class A_SceneObject extends Sprite {
	protected var boundary:Rectangle;
	protected var vx:Number;
	protected var vy:Number;
	protected var ax:Number;
	protected var ay:Number;

	public A_SceneObject(
	    boundaryStart:Rectangle=new Rectangle(0,0,1024,768);
	    xStart:Number=0,
	    yStart:Number=50,
	    vxStart:Number=3,
	    vyStart:Number=0,
	    axStart:Number=0,
	    ayStart:Number=0)
	{
	    boundary = boundaryStart;
	    x = xStart;
	    y = yStart;
	    vx = vxStart;
	    vy = vyStart;
	}

	// TODO do function passing for the following
	// - boundary detection (save as var and use for tests)

	// takes an array of the objects it's colliding with 
	protected Update() {
	    // advect motion
	    vx += ax;
	    vy += ay;
	    x += vx;
	    y += vy;

	    // deal with collisions
	    
	    // deal with boundaries
	    boundaryDetectionWrap();
	}

	// boundary detection: wrap:
	// - top = nothing
	// - bottom = stop
	// - left = wrap to right
	// - right = wrap to left
	protected boundaryDetectionWrap():void {
	    if (y + height > boundary.bottom) {
		//stop
		y = boundary.bottom - height;
		ay = 0;
		vy = 0;
	    }
	    if (x < boundary.left) {
		// wrap to right
		
	    }
	    if (x > boundary.right) {
		// wrap to left
	    }
	}
    }
}
