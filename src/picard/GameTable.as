package picard
{
	import com.transmote.flar.FLARManager;
	import com.transmote.flar.tracker.FLARToolkitManager;
	import com.transmote.utils.time.FramerateDisplay;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import picard.events.CardEvent;
		
	/**
	 * The base class for every game.  Shouldn't be instantiated on its own.
	 */
	public class GameTable extends Sprite {
		
		protected var flarConfigFile:String = "../resources/flarConfig.xml"; // url to config file for flarmanager
		protected var flarManager:FLARManager;
		protected var cardHandler:CardHandler;
		
		protected var cardsInPlay:Dictionary;
		
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
			trace("Card", event.card.id, "of type",event.card.type,  "Added...");
		}
		
		private function cardRemoved(event:CardEvent):void {
			
			trace("card remove event");
			this.removeChild(event.card)
			delete this.cardsInPlay[event.card.id];
			trace("Card", event.card.id, "Removed...");
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
		
	}
}