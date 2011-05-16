package picard.games.humansvsaliens
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Player extends EventDispatcher {
		
		private var _side:String;
		
		public function Player(side:String) {
			this._side = side;
		}
		
		public function get side():String {
			return this._side;
		}
	}
}