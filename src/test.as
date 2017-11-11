package {
  import flash.display.Sprite;
  import flash.events.*;
  
  [SWF(width="500", height="500", backgroundColor="#FFFF00")]
  public class test extends Sprite {
    public function test() {
      trace("START TEST");
	  var circle1:Sprite = new Sprite();
	  circle1.graphics.beginFill(0xFFCC00);
	  circle1.graphics.drawCircle(100, 100, 50);
	  circle1.buttonMode = true;
	  //circle1.addEventListener(MouseEvent.CLICK, clicked);
	  
	  var circle2:Sprite = new Sprite();
	  circle2.graphics.beginFill(0xFFCC00);
	  circle2.graphics.drawCircle(10, 200, 50);
	  circle2.buttonMode = false;
	  //circle2.addEventListener(MouseEvent.CLICK, clicked);
	  
	  addChild(circle1);
	  addChild(circle2);

      trace("END_TEST");
    }
  }
}
