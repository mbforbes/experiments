package {
    import flash.display.Sprite;
    import flash.events.Event;
    import Settings;

    //TODO find better solution for width, height, color, etc. so that these don't
    // have to be copied in the Settings class too...
    [Frame(factoryClass="Loader")]
    [SWF(backgroundColor="0x444444", width="1024", height="768", frameRate="60")]
    public class Test2 extends Sprite {

	public function Test2() {
	    addEventListener(Event.ENTER_FRAME, initWhenDisplayed);
	}
	private function initWhenDisplayed(event:Event):void {
	    if (parent != null) {
		startGame();
		removeEventListener(Event.ENTER_FRAME, initWhenDisplayed);
	    }
	}

	// game starts here!!
	public function startGame():void {
	    trace("hello, world!");
	 
	    var level1:Level1 = new Level1();
	    addChild(level1);
	    level1.Start();
	}
    }
}