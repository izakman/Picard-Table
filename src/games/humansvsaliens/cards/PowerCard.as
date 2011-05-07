package games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	public class PowerCard extends HVACard {
		
		public function PowerCard(marker:FLARMarker, cardID:Number) {
			super(marker, cardID);
			this.cardType = marker.patternId;
			switch (cardType) {
				case HVACard.POWERBOOST1:
					this.cardPower = 1; break;
				case HVACard.POWERBOOST2:
					this.cardPower = 2; break;
			}
		}
		
	}
}