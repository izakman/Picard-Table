package picard
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * Superclass for all game states. A GameState is basically a set of event
	 * handlers for required for a particular part of a game.
	 * 
	 */
	public class GameState extends EventDispatcher {
		
		public function GameState(currentCards:Dictionary) {
			
		}
		
	}
}