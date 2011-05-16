package picard.games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.display.Sprite;
	
	import picard.Card;
	import picard.GameTable;
	import picard.ICardFactory;
	import picard.games.humansvsaliens.Side;
	
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
			this.cardSprite = new Sprite();
			var pieceSize:int = 40;
			this.cardSprite.graphics.beginFill(0x2222FF);
			this.cardSprite.graphics.moveTo(pieceSize/2, pieceSize);
			this.cardSprite.graphics.lineTo(0, 0);
			this.cardSprite.graphics.lineTo(pieceSize, 0);
			this.cardSprite.graphics.lineTo(pieceSize/2, pieceSize);
			this.cardSprite.graphics.endFill();
			this.cardSprite.x = 0-(pieceSize/2);
			this.cardSprite.y = 0-(pieceSize/2);
			this.addChild(cardSprite);
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