package picard
{
	import com.transmote.flar.FLARManager;
	import com.transmote.flar.marker.FLARMarker;
	import com.transmote.flar.tracker.FLARToolkitManager;
	import com.transmote.utils.time.FramerateDisplay;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import picard.events.CardEvent;
	import picard.games.humansvsaliens.cards.HVACard;
		
	/**
	 * The base class for every game.  Shouldn't be instantiated on its own.
	 */
	public class GameTable extends Sprite {
		
		public static const TABLE_WIDTH:Number = 960;
		public static const TABLE_HEIGHT:Number = 600;
		
		protected var flarConfigFile:String = "../resources/flarConfig.xml"; // url to config file for flarmanager
		protected var flarManager:FLARManager;
		protected var cardHandler:CardHandler;
		
		public var cardsInPlay:Dictionary;
		
		protected var showSource:Boolean = true;
		protected var sourceAlpha:Number = 0.5;
		
		protected var cardFactory:ICardFactory;
		
		/**
		 * Constructs a new GameTable.
		 */
		public function GameTable() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			this.cardsInPlay = new Dictionary();
			this.addBackground();
			this.displayFramerate();
			//TODO: Wait for a game start event from cardhandler to start game
		}
		
		/**
		 * Initializes the parts needed for the game to start
		 *  
		 * @param event
		 */
		private function init(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			this.flarManager = new FLARManager(flarConfigFile, new FLARToolkitManager(), this.stage);
			if (showSource) this.addSource();
			
			this.cardHandler = new CardHandler(this.cardFactory, this.flarManager);
			this.startGame();
		}
		
		private function cardAdded(event:CardEvent):void {
			this.addChild(event.card);
			this.cardsInPlay[event.card.id] = event.card;
			trace("<< Card", event.card.id, "added >>");
			trace("   >> Card is a ", event.card.side, getQualifiedClassName(event.card));
		}
		
		private function cardRemoved(event:CardEvent):void {
			this.removeChild(event.card);
			delete this.cardsInPlay[event.card.id];
			trace("<< Card", event.card.id, "removed >>");
		}
		
		protected function startGame():void {
			this.cardHandler.addEventListener(CardEvent.ADDED, this.cardAdded);
			this.cardHandler.addEventListener(CardEvent.REMOVED, this.cardRemoved);
			this.cardHandler.startHandling();
		}
		
		protected function endGame():void {
			
		}
		
		private function displayFramerate():void {
			var framerateDisplay:FramerateDisplay = new FramerateDisplay();
			this.addChild(framerateDisplay);
		}
		
		private function addSource():void {
			var videoSource:Sprite = Sprite(this.flarManager.flarSource);
			videoSource.alpha = sourceAlpha;
			this.addChildAt(videoSource, 0);
		}
		
		protected function addBackground():void {
			
		}
		
////////////////////////////////////
		
		public static function distanceBetweenCards(card1:Card, card2:Card):Number {
			//distance equation from - http://www.ilike2flash.com/2011/01/as3-distance-between-two-points.html
			return Math.sqrt( (card1.x - card2.x) * (card1.x - card2.x) + (card1.y - card2.y) * (card1.y - card2.y) );
		}
		
		public static function distanceBetweenMarkers(marker1:FLARMarker, marker2:FLARMarker):Number {
			//distance equation from - http://www.ilike2flash.com/2011/01/as3-distance-between-two-points.html
			return Math.sqrt( (marker1.centerpoint.x - marker2.centerpoint.x) * (marker1.centerpoint.x - marker2.centerpoint.x) + (marker1.centerpoint.y - marker2.centerpoint.y) * (marker1.centerpoint.y - marker2.centerpoint.y) );
		}
		
	}
}