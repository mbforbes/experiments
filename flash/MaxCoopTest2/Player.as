package {
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.utils.Dictionary;

    public class Player extends A_SceneObject {

	// externally set to load models
	public var modelDictionary:Dictionary;

	// externalize/abstract input?
	protected var lastInputUp:Boolean = false; // tracking previous state
	protected var inputUp:Boolean = false;
	protected var inputDown:Boolean = false;
	protected var inputLeft:Boolean = false;
	protected var inputRight:Boolean = false;
	protected var jumpBehavior:String;

	// TODO do something better for default...
	private var currentModel:String = "(default)";

	public function Player(
	    xStart:Number=0,
	    yStart:Number=0,
	    vxStart:Number=0,
	    vyStart:Number=0,
	    axStart:Number=0,
	    ayStart:Number=0)
	{
	    super(
		xStart,
		yStart,
		vxStart,
		vyStart,
		axStart,
		ayStart);
	    
	    modelDictionary = new Dictionary();
	    boundaryBehavior = Settings.BOUNDARY_STOP;
	    getsKeyboardInput = true;
	    jumpBehavior = Settings.PLAYER_JUMP_INAIR;
	}

	public override function receiveKeyDown(event:KeyboardEvent):void {
	    switch(event.keyCode) {
		case Keyboard.UP:
		inputUp = true;
		break;

		case Keyboard.SPACE:
		inputUp = true;
		break;

		case Keyboard.DOWN:
		inputDown = true;
		break;

		case Keyboard.LEFT:
		inputLeft = true;
		break;

		case Keyboard.RIGHT:
		inputRight = true;
		break;
	    }
	}

	public override function receiveKeyUp(event:KeyboardEvent):void {
	    switch(event.keyCode) {
		case Keyboard.UP:
		inputUp = false;
		break;

		case Keyboard.SPACE:
		inputUp = false;
		break;

		case Keyboard.DOWN:
		inputDown = false;
		break;

		case Keyboard.LEFT:
		inputLeft = false;
		break;

		case Keyboard.RIGHT:
		inputRight = false;
		break;
	    }
	}
	
	protected override function getForces():void {
	    super.getForces();

	    ay += Settings.GRAVITY;

	    if (inputUp) {
		if (canJump()) {
		    vy = Settings.PLAYER_JUMPVEL;
		    updateModel(Settings.PLAYER_FACING_UP);
		}
	    }
	    // currently nothing for down
	    if (inputRight) {
		ax += Settings.PLAYER_ACCEL;
		updateModel(Settings.PLAYER_FACING_RIGHT);
	    } else if (inputLeft) {
		ax -= Settings.PLAYER_ACCEL;
		updateModel(Settings.PLAYER_FACING_LEFT);
	    }

	    // set state
	    lastInputUp = inputUp;
	}

	// change to "updateAnimation" once we get animated sprites...
	protected function updateModel(playerState:String):void {
	    if (currentModel != playerState) {
		if (modelDictionary[playerState] != null) {
		    removeChildren();
		    addChild(modelDictionary[playerState]);
		    currentModel = playerState;
		}
	    }
	}

	protected override function applyFriction():void {
	    vx *= Settings.PLAYER_FRICTION_X;
	    vy *= Settings.PLAYER_FRICTION_Y;
	}

	protected function canJump():Boolean {
	    // ?: provide to non-player things? for now, as specific as possible...
	    switch (jumpBehavior) {
		case Settings.PLAYER_JUMP_ONGROUND:
		return y + height == boundary.bottom;
		break;

		case Settings.PLAYER_JUMP_INAIR:
		return !lastInputUp;
		break;

		default:
		return false;
		break;
	    }
	}
    }
}
