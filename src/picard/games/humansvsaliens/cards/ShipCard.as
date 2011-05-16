package picard.games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	public class ShipCard extends HVACard {
		
		private var currentPower:Number;
		
		public function ShipCard(marker:FLARMarker, cardID:Number) {
			super(marker, cardID);
			this.cardType = marker.patternId;
			switch (cardType) {
				case HVACard.SCOUT:
					this.currentPower = this.cardPower = 1; break;
				case HVACard.FIGHTER:
					this.currentPower = this.cardPower = 2; break;
				case HVACard.DEFENDER:
					this.currentPower = this.cardPower = 3; break;
			}
		}
		
		public function boostPower(powerCard:PowerCard):void {
			this.currentPower = this.cardPower + powerCard.power;
			//modify card power sprite
		}
		
		public function removeBoost():void {
			this.currentPower = this.cardPower;
			//modify card power sprite
		}
		
		
	}
}