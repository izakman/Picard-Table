package picard.games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.display.Sprite;
	
	import picard.Card;
	import picard.GameTable;
	import picard.ICardFactory;
	import picard.games.humansvsaliens.Side;
	import picard.games.humansvsaliens.graphics.CardSprite;
	
	public class HVACard extends Card {
		
		// Contants match up with the patternIDs of the markers
		public static const SCOUT:Number = 0;
		public static const FIGHTER:Number = 1;
		public static const DEFENDER:Number = 2;
		public static const POWERBOOST1:Number = 3;
		public static const POWERBOOST2:Number = 4;
		
		protected var cardPower:Number;
		
		public function HVACard(marker:FLARMarker, cardID:Number) {
			super(marker, cardID);
		}
		
		override protected function drawCard():void {
			this.cardSprite = new CardSprite(this);
			this.addChild(this.cardSprite);
		}
		
		override protected function determinSide():String {
			if (this.x < GameTable.TABLE_WIDTH/2) {
				return Side.HUMAN;
			} else {
				return Side.ALIEN;
			}
		}
		
		public function get power ():Number {
			return this.cardPower;
		}
		
	}
}