package picard.games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import picard.GameTable;
	import picard.events.CardEvent;
	
	public class PowerCard extends HVACard {
		
		public var shipBoosted:ShipCard = null;
		
		public function PowerCard(marker:FLARMarker, cardID:Number) {
			super(marker, cardID);
			switch (cardType) {
				case HVACard.POWERBOOST1:
					this.cardPower = 1; break;
				case HVACard.POWERBOOST2:
					this.cardPower = 2; break;
			}
		}
		
		override protected function enterFrame(e:Event):void {
			super.enterFrame(e);
			this.checkProximity();
		}
		
		private function checkProximity():void {
			var sideCards:Array = new Array();
			for each (var card:HVACard in Global.vars.gameTable.cardsInPlay) {
				if (this.side == card.side && card is ShipCard) {
					sideCards.push({card:card, distance:GameTable.distanceBetweenCards(this, card)});
				}
			}
			if (sideCards.length > 0) {
				sideCards.sortOn("distance");
				if (sideCards[0] != this.shipBoosted) {
					if (this.shipBoosted) {
						this.disablePowerBoost();
					}
					this.activatePowerBoost(sideCards[0]);
				}
			}
		}
		
		public function activatePowerBoost(card:ShipCard):void {
			this.shipBoosted = card;
			this.shipBoosted.boostPower(this);
			this.enableBeam(this.shipBoosted);
		}
		
		public function disablePowerBoost():void {
			this.disableBeam();
			this.shipBoosted.removeBoost();
			this.shipBoosted = null;
		}
		
		private function enableBeam(card:ShipCard):void {
			//add graphics
		}
		
		private function disableBeam():void {
			//remove graphics
		}
		
		override public function cleanUp():void {
			super.cleanUp();
			if (this.shipBoosted) {
				this.disablePowerBoost();
			}
		}
		
		
		
	}
}