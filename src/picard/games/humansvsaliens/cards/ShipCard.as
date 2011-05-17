package picard.games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.events.Event;
	
	public class ShipCard extends HVACard {
		
		public var currentPower:Number;
		public var powerBooster:PowerCard = null;
		
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
			this.powerBooster = powerCard;
			this.currentPower = this.cardPower + this.powerBooster.power;
			trace("   >> Power boosted by", powerCard.power);
			//modify card power sprite
		}
		
		public function removeBoost():void {
			this.currentPower = this.cardPower;
			this.powerBooster = null;
			trace("   >> Boost removed");
			//modify card power sprite
		}
		
		override public function cleanUp(e:Event):void {
			super.cleanUp(e);
			if (this.powerBooster) {
				this.powerBooster.disablePowerBoost();
			}
		}
				
		
	}
}