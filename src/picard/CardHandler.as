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

	/**
	 * Wraps up the marker events dispatched by the FLARManager so that the 
	 * game only sees the card events it needs to.
	 */
	public class CardHandler extends EventDispatcher {
		
		private const REMOVAL_DELAY:Number = 1000; //in milliseconds
		private const REPLACE_RANGE:Number = 200; //in pixels
		private const PLACEMENT_DELAY:Number = 1000; //in milliseconds
		
		private var newCardID:Number = 0;
		
		private var cardFactory:ICardFactory;
		private var flarManager:FLARManager;
		
		private var markersInPlay:Dictionary; // the markers that are currently in play mapped to their cards
		private var cardsPendingPlacement:Dictionary;
		private var cardsPendingRemoval:Dictionary;
		
		
		/**
		 * Constructs a new CardHandler.
		 * 
		 * @param cardFactory A factory implementing ICardFactory that can 
		 * 					  create the cards needed for the particular game.
		 * @param flarManager The FLARManager object that detects the markers 
		 * 					  for the game.
		 */
		public function CardHandler(cardFactory:ICardFactory, flarManager:FLARManager) {
			this.cardFactory = cardFactory;
			this.flarManager = flarManager;
			this.markersInPlay = new Dictionary();
			this.cardsPendingPlacement =  new Dictionary();
			this.cardsPendingRemoval =  new Dictionary();
		}
		
		/**
		 * Starts the CardHander's monitoring and dispatching of events.
		 */
		public function startHandling():void {
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_ADDED, this.onMarkerAdded2);
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_REMOVED, this.onMarkerRemoved2);
		}
		
		
		private function onMarkerAdded(event:FLARMarkerEvent):void {
			this.newCardID += 1;
			var card:Card = this.cardFactory.createNewCard(event.marker, newCardID);
			this.markersInPlay[event.marker] = card;
//			for each (var c:Card in this.markersInPlay) {
//				trace("<< ", c.type, " >>");
//			}
			dispatchEvent(new CardEvent(CardEvent.ADDED, card));
		}
		
		private function onMarkerRemoved(event:FLARMarkerEvent):void {
			var card:Card = markersInPlay[event.marker];
			delete this.markersInPlay[event.marker];
//			for each (var c:Card in this.markersInPlay) {
//				trace("<< ", c.type, " >>");
//			}
			dispatchEvent(new CardEvent(CardEvent.REMOVED, card));
		}
		
		private function onMarkerAdded2(event:FLARMarkerEvent):void {
			trace("adding");
			//get the card if a card pending removal is within the time and range allowed
			var card:Card = isCardStillOnTable(event.marker);
			if (card == null) {
				//create a new card
				card = this.cardFactory.createNewCard(event.marker, this.newCardID += 1);
				card.placementTimer = new CardTimer(card, PLACEMENT_DELAY, 1);
				card.placementTimer.addEventListener(TimerEvent.TIMER, cardAdded);
				card.placementTimer.start();
				this.cardsPendingPlacement[event.marker] = card;
				trace("|| Card", card.id, "["+card.marker.sessionId+"]", "pending placement");
			} else {
				//replace marker within card
				var oldMarker:FLARMarker = card.marker;
				var newMarker:FLARMarker = event.marker;
				card.removalTimer.stop();
				delete this.cardsPendingRemoval[oldMarker];
				delete this.markersInPlay[oldMarker]; //delete existing marker from play
				this.markersInPlay[newMarker] = card; //add new marker to play
				card.replaceMarker(newMarker);
				trace("|| Card", card.id, "["+card.marker.sessionId+"]", "marker replaced");
			}
		}
		
		private function onMarkerRemoved2(event:FLARMarkerEvent):void {
			trace("removing");
			var card:Card = this.cardsPendingPlacement[event.marker];
			if(card){
				card.placementTimer.stop();
				delete this.cardsPendingPlacement[event.marker];
				trace("|| Card", card.id, "["+card.marker.sessionId+"]", "removed from pending placement");
			} else {
				card = this.markersInPlay[event.marker];
				card.removalTimer = new CardTimer(card, REMOVAL_DELAY, 1);
				card.removalTimer.addEventListener(TimerEvent.TIMER, cardRemoved);
				card.removalTimer.start();
				this.cardsPendingRemoval[event.marker] = card;
				trace("|| Card", card.id, "["+card.marker.sessionId+"]", "pending removal");
			}
		}
		
		/**
		 * Given a newly added FLARMarker, the method determines if should be 
		 * regarded as a new card, or one already existing on the table.
		 * 
		 * @param marker The new FLARMarker.
		 * 
		 * @return The Card object found to be the same as the new marker.  If 
		 * 		   no card is found, returns null instead.
		 */
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

		/**
		 * Calculates the distance between the given Card and FLARMarker.
		 * 
		 * @param card
		 * @param marker
		 * @return The distance in pixels.
		 */
		private function distanceBetween(card:Card, marker:FLARMarker):Number {
			//distance equation from - http://www.ilike2flash.com/2011/01/as3-distance-between-two-points.html
			return Math.sqrt( (card.x - marker.centerpoint.x) * (card.x - marker.centerpoint.x) + (card.y - marker.centerpoint.y) * (card.y - marker.centerpoint.y) );
		}
		
		
		/**
		 * Handles the TimerEvent that occurs when an added marker should now 
		 * be added as a actual card and dispatches a new CardEvent to say as 
		 * such.
		 * 
		 * @param event A TimerEvent.
		 */
		private function cardAdded(event:TimerEvent):void {
			var card:Card = event.target.card;
			delete this.cardsPendingPlacement[card.marker];
			this.markersInPlay[card.marker] = card;
			dispatchEvent(new CardEvent(CardEvent.ADDED, card));
		}
		
		/**
		 * Handles the TimerEvent that occurs when an removed marker should now 
		 * remove the associated card and dispatches a new CardEvent to say as 
		 * such.
		 * 
		 * @param event A TimerEvent.
		 */
		private function cardRemoved(event:TimerEvent):void {
			var card:Card = event.target.card;
			delete this.cardsPendingRemoval[card.marker];
			delete this.markersInPlay[card.marker];
			dispatchEvent(new CardEvent(CardEvent.REMOVED, card));
		}

	}
}