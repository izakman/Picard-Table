package picard.events
{
	import flash.events.Event;
	
	import picard.Card;
	
	public class CardEvent extends Event {
		
		public static const ADDED:String = "cardAdded";
		public static const UPDATED:String = "cardUpdated";
		public static const REMOVED:String = "cardRemoved";
		
		private var _card:Card;
		
		public function CardEvent(type:String, card:Card, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this._card = card;
		}
		
		public function get card():Card {
			return this._card;
		}
		
		public override function clone () :Event {
			return new CardEvent(this.type, this.card, this.bubbles, this.cancelable);
		}
		
	}
}