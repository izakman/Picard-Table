package picard.timers
{
	import flash.utils.Timer;
	
	import picard.Card;
	
	public class CardTimer extends Timer {
		
		private var _card:Card;
		
		public function CardTimer(card:Card, delay:Number, repeatCount:int=0) {
			super(delay, repeatCount);
			this._card = card;
		}
		
		public function get card():Card {
			return this._card;
		}
	}
}