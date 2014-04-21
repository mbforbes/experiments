package {
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;

    // from http://www.bit-101.com/blog/?p=946
    // 1) The factory class has to extend MovieClip. NOT Sprite! It actually has
    // frames, so it should be a MovieClip.
    public class Loader extends MovieClip {
	public function Loader() {
	    stop();
	    stage.scaleMode = StageScaleMode.NO_SCALE;
	    stage.align = StageAlign.TOP_LEFT;
	    addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:Event):void {
	    graphics.clear();
	    if (framesLoaded == totalFrames) {
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		nextFrame();
		init();
	    } else {
		var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
		graphics.beginFill(0);
		graphics.drawRect(0, stage.stageHeight/2 - 10,
		    stage.stageWidth * percent, 20);
		graphics.endFill();
	    }
	}

	private function init():void {
	    var mainClass:Class = Class(getDefinitionByName("Test2"));
	    if (mainClass) {
		var app:Object = new mainClass();
		addChild(app as DisplayObject);
	    }
	}
    }
}
