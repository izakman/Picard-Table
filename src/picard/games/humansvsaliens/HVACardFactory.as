package picard.games.humansvsaliens
{
	import com.transmote.flar.marker.FLARMarker;
	
	import picard.Card;
	import picard.ICardFactory;
	import picard.games.humansvsaliens.cards.HVACard;
	import picard.games.humansvsaliens.cards.ShipCard;
	import picard.games.humansvsaliens.cards.PowerCard;
	
	public class HVACardFactory implements ICardFactory {
		
		public function createNewCard(marker:FLARMarker, cardID:Number):Card {
			var cardType:Number = marker.patternId;
			switch (cardType) {
				case HVACard.SCOUT:
				case HVACard.FIGHTER:
				case HVACard.DEFENDER:
					return new ShipCard(marker, cardID) as Card;
				case HVACard.POWERBOOST1:
				case HVACard.POWERBOOST2:
					return new PowerCard(marker, cardID) as Card;
			}
			throw new Error("Unknown pattern ID");
		}
	}
}