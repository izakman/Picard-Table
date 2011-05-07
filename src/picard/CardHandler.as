package picard
{
	import com.transmote.flar.FLARManager;
	import com.transmote.flar.marker.FLARMarker;
	import com.transmote.flar.marker.FLARMarkerEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import picard.events.CardEvent;
	import picard.timers.CardTimer;

	public class CardHandler extends EventDispatcher {
		
		private const REMOVAL_DELAY:Number = 1000; //in milliseconds
		private const REPLACE_RANGE:Number = 40; //in pixels
		private const PLACEMENT_DELAY:Number = 1000; //in milliseconds
		
		private var newCardID:Number = 0;
		
		private var cardFactory:ICardFactory;
		private var flarManager:FLARManager;
		
		private var markersInPlay:Dictionary; // the markers that are currently in play mapped to their cards
		private var cardsPendingPlacement:Dictionary;
		private var cardsPendingRemoval:Dictionary;
		
		
		public function CardHandler(cardFactory:ICardFactory, flarManager:FLARManager) {
			this.cardFactory = cardFactory;
			this.flarManager = flarManager;
			this.markersInPlay = new Dictionary();
			this.cardsPendingPlacement =  new Dictionary();
			this.cardsPendingRemoval =  new Dictionary();
		}
		
		public function startHandling():void {
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_ADDED, this.onMarkerAdded);
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_REMOVED, this.onMarkerRemoved);
		}
		
		
		private function onMarkerAdded(event:FLARMarkerEvent):void {
			this.newCardID += 1;
			var card:Card = this.cardFactory.createNewCard(event.marker, newCardID);
			this.markersInPlay[event.marker] = card;
			dispatchEvent(new CardEvent(CardEvent.ADDED, card));
		}
		
		private function onMarkerRemoved(event:FLARMarkerEvent):void {
			var card:Card = markersInPlay[event.marker];
			delete this.markersInPlay[event.marker];
			dispatchEvent(new CardEvent(CardEvent.REMOVED, card));
		}
		
		private function TESTonMarkerAdded(event:FLARMarkerEvent):void {
			//get the card if a card pending removal is within the time and range allowed
			var card:Card = isCardStillOnTable(event.marker);
			if (card == null) {
				//create a new card
				card = this.cardFactory.createNewCard(event.marker, this.newCardID += 1);
				card.placementTimer = new CardTimer(card, PLACEMENT_DELAY, 1);
				card.placementTimer.addEventListener(TimerEvent.TIMER, cardAdded);
				card.placementTimer.start();
				this.cardsPendingPlacement[event.marker] = card;
			} else {
				//replace marker within card
				card.removalTimer.stop();
				delete this.cardsPendingRemoval[event.marker];
				card.replaceMarker(event.marker);
			}
		}
		
		private function TESTonMarkerRemoved(event:FLARMarkerEvent):void {
			//check if the card was pending
			if (this.cardsPendingPlacement[event.marker]) {
				this.cardsPendingPlacement[event.marker].placementTimer.stop();
				delete this.cardsPendingPlacement[event.marker];
				//now do nothing as marker addition was probably a glitch
			} else { //card is on the table
				var card:Card = markersInPlay[event.marker];
				card.removalTimer = new CardTimer(card, REMOVAL_DELAY, 1);
				card.removalTimer.addEventListener(TimerEvent.TIMER, cardRemoved);
				card.removalTimer.start();
				this.cardsPendingRemoval[event.marker] = card;
			}
		}
		
		private function isCardStillOnTable(marker:FLARMarker):Card {
			var possibleCards:Array = new Array();
			for each (var card:Card in this.cardsPendingRemoval) {
				//check if card is waiting to be removed and is the same type
				if (card.type == marker.patternId) {
					//check if card is within replacement range
					var distance:Number = distanceBetween(card, marker);
					if (distance <= REPLACE_RANGE) {
						possibleCards.push({"card":card, "distance":distance});
					}
				}
			}
			//get the closest card if possible cards were found
			if (possibleCards.length != 0) {
				possibleCards.sortOn("distance", Array.NUMERIC);
				return possibleCards[0]["card"];
			} else {
				return null;
			}
		}

		private function distanceBetween(card:Card, marker:FLARMarker):Number {
			//distance equation from - http://www.ilike2flash.com/2011/01/as3-distance-between-two-points.html
			return Math.sqrt( (card.x - marker.centerpoint.x) * (card.x - marker.centerpoint.x) + (card.y - marker.centerpoint.y) * (card.y - marker.centerpoint.y) );
		}
		
		
		private function cardAdded(event:TimerEvent):void {
			var card:Card = event.target.card;
			this.markersInPlay[card.marker] = card;
			dispatchEvent(new CardEvent(CardEvent.ADDED, card));
		}
		
		private function cardRemoved(event:TimerEvent):void {
			var card:Card = event.target.card;
			delete this.markersInPlay[card.marker];
			dispatchEvent(new CardEvent(CardEvent.REMOVED, card));
		}

	}
}