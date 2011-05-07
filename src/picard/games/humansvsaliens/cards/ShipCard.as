package picard.games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	public class ShipCard extends HVACard {
		
		public function ShipCard(marker:FLARMarker, cardID:Number) {
			super(marker, cardID);
			this.cardType = marker.patternId;
			switch (cardType) {
				case HVACard.SCOUT:
					this.cardPower = 1; break;
				case HVACard.FIGHTER:
					this.cardPower = 2; break;
				case HVACard.DEFENDER:
					this.cardPower = 3; break;
			}
		}
		
		
	}
}