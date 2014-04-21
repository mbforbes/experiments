package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    //TODO find better solution for width, height, color, etc. so that these don't
    // have to be copied in the Settings class too...
//    [Frame(factoryClass="Loader")]
    [SWF(backgroundColor="0x444444", width="1024", height="768", frameRate="60")]
    public class CameraTest extends Sprite {

	public function CameraTest() {
	    init();
	}

	private function init():void {
	    var circle:Sprite = new Sprite();
	    circle.graphics.beginFill(0xffcc00);
	    circle.graphics.drawCircle(0,0,100);
	    circle.x = 100;
	    circle.y = 100;
	    circle.scrollRect = new Rectangle(0, 0, 400, 400);
	    addChild(circle);

	    circle.addEventListener(MouseEvent.CLICK, onCircleClick);
	}

	private function onCircleClick(event:MouseEvent):void {
	    var rect:Rectangle = event.target.scrollRect;
	    rect.y -= 5;
	    event.target.scrollRect = rect;
	}

	// public function CameraTest() {
	//     addEventListener(Event.ENTER_FRAME, initWhenDisplayed);
	// }
	// private function initWhenDisplayed(event:Event):void {
	//     if (parent != null) {
	// 	startGame();
	// 	removeEventListener(Event.ENTER_FRAME, initWhenDisplayed);
	//     }
	// }
    }
}