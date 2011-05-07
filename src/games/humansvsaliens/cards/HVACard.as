package games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.display.Sprite;
	
	import games.Card;
	import games.ICardFactory;
	
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
		
		override protected function addSprite():void {
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
		
	}
}