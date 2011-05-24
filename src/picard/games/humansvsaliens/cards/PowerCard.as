package picard.games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.core.MovieClipLoaderAsset;
	
	import org.osmf.events.TimeEvent;
	
	import picard.GameTable;
	import picard.events.CardEvent;
	
	public class PowerCard extends HVACard {
		
		public var shipBoosted:ShipCard = null;
		private var checkTimer:Timer = new Timer(1000);
		
		public function PowerCard(marker:FLARMarker, cardID:Number) {
			super(marker, cardID);
			switch (cardType) {
				case HVACard.POWERBOOST1:
					this.cardPower = 1; break;
				case HVACard.POWERBOOST2:
					this.cardPower = 2; break;
			}
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
		}
		
		private function addedToStage(e:Event):void {
			this.checkTimer.start();
			this.checkTimer.addEventListener(TimerEvent.TIMER, this.checkProximity);
		}
		
		private function checkProximity(e:TimerEvent):void {
			//trace("--------------------- timer");
			var sideCards:Array = new Array();
			for each (var card:HVACard in Global.vars.gameTable.cardsInPlay) {
				if (this.side == card.side && card is ShipCard) {
					sideCards.push({card:card, distance:GameTable.distanceBetweenCards(this, card)});
				}
			}
			if (sideCards.length > 0) {
				sideCards.sortOn("distance");
				if (sideCards[0].card != this.shipBoosted) {
					if (this.shipBoosted) {
						this.disablePowerBoost();
					}
					this.activatePowerBoost(sideCards[0].card);
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
		
		override public function cleanUp(e:Event):void {
			super.cleanUp(e);
			if (this.shipBoosted) {
				this.disablePowerBoost();
			}
			this.checkTimer.removeEventListener(TimerEvent.TIMER, this.checkProximity);
			this.checkTimer.stop();
		}
		
		
		
	}
}