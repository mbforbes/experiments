package;

import flash.display.Sprite;
import nape.util.Debug;
import nape.util.BitmapDebug;

class MaxTest extends Sprite {
    var debug:Debug;

    function new() {
        super();
        debug = new BitmapDebug(stage.stageWidth,
        	stage.stageHeight,
        	stage.color);        
    }
}
