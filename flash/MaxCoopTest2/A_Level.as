package {

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;

    // TODO prive need to be changed to protected?

    public class A_Level extends Sprite {

	protected var music:Sound;
	protected var channel:SoundChannel;
	protected var sceneObjects:Array;

	public function A_Level() {
	    sceneObjects = new Array();
	    init();
	}


	// instances should override this and do the loading and setting up they want
	protected function init():void {
	    
	}

	public function Start():void {
	    if (music != null) {
		channel = music.play(0,100);
	    }

	    for (var i:uint = 0; i < sceneObjects.length; i++) {
		if (sceneObjects[i].getsKeyboardInput) {
		    stage.addEventListener(KeyboardEvent.KEY_DOWN, sceneObjects[i].receiveKeyDown);
		    stage.addEventListener(KeyboardEvent.KEY_UP, sceneObjects[i].receiveKeyUp);
		}
	    }
	    
	    addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	public function End():void {
	    DeregisterAll();
	    //TODO stop Sound
	}

	private function onEnterFrame(event:Event):void {
	    Update();
	}
	
	// consider reworking to use splice / or function calls to remove all at once
	private function DeregisterAll():void {
	    for (var i:uint = sceneObjects.length - 1; i >= 0; i--) {
		unsafeRemoveObjectAt(i);
	    }
	}

	public function Register(s:A_SceneObject):void {
	    if (s != null) {
		addChild(s);
		sceneObjects.push(s);
	    }
	}
	

	public function Deregister(s:A_SceneObject):void {
	    if (s != null) {
		var pos:Number = sceneObjects.indexOf(s);
		if (pos != -1) {
		    unsafeRemoveObjectAt(pos);
		}
	    }
	}
	
	// called only when the position has been checked and the object is
	// there and needs to be removed
	private function unsafeRemoveObjectAt(pos:uint):void {
	    var removed:A_SceneObject = sceneObjects.splice(pos,1)[0];
	    removeChild(removed);
	    removed.Destroy();
	}

	public function Update():void {
	    for (var i:uint = 0; i < sceneObjects.length; i++) {
		// figure out collisions
		//sceneObjects[i].collidedObjects ...

		// call update on each object
		sceneObjects[i].Update();
	    }
	}
    }
}
