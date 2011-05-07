package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	[SWF(width="640", height="480", frameRate="30", backgroundColor="#000000")]
	public class Tester extends Sprite {
		
		private var myclass:MyClass1 = new MyClass1();
		
		public function Tester() {
			super();
			
//			var name:String = "john";
//			var myclass:String = "wooooooo";
//			var t1:Object = {"name":name, "myclass":myclass};
//			for (var k:* in t1) {
//				trace(k, t1[k]);
//			}
			
			var dict:Dictionary = new Dictionary();
			var myclass:MyClass1 = new MyClass1();
//			var addTimer:Timer = new Timer(2000, 1);
//			addTimer.addEventListener(TimerEvent.TIMER, cardAdded);
//			addTimer.start();
			
			dict[myclass] = "woooooo";
			trace(dict[myclass]);
//			dict[myclass].stop();
			delete dict[myclass];
			var temp:String = dict[myclass];
			trace(temp);
			
			
//			var id:Number = 0;
//			
//			tester1(id += 1);
//			tester1(id += 1);
//			tester1(id += 1);
			
			
		}
		
		private function cardAdded(e:Event):void {
			trace("timer done");
			trace(e.target);
		}
		
		private function tester1(id:Number):void {
			trace(id);
		}
		
	}
}

class MyClass1 {
	
	public function MyClass1() {
		super();
	}
	
	public function toString():String {
		return "--string of MyClass1--";
	}
	
}