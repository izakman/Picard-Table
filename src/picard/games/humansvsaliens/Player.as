package picard.games.humansvsaliens
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Player extends EventDispatcher {
		
		private var _side:Side;
		
		public function Player(side:Side) {
			this._side = side;
		}
		
		public function get side():Side {
			return this._side;
		}
	}
}