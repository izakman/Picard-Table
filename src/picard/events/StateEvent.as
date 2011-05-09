package picard.events
{
	import flash.events.Event;
	
	public class StateEvent extends Event {
		
		public static const ENDED:String = "ended";
		
		public function StateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}