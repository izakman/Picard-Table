package games
{
	import com.transmote.flar.FLARManager;
	import com.transmote.flar.tracker.FLARToolkitManager;
	import com.transmote.utils.time.FramerateDisplay;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import games.events.CardEvent;
		
	public class GameTable extends Sprite {
		
		protected var configFile:String = "../resources/flarConfig.xml"; // url to config file for flarmanager
		protected var flarManager:FLARManager;
		protected var cardHandler:CardHandler;
		
		protected var cardsInPlay:Dictionary;
		
		protected var showSource:Boolean = true;
		protected var sourceAlpha:Number = 0.5;
		
		protected var cardFactory:ICardFactory;
		
		public function GameTable() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			this.cardsInPlay = new Dictionary();
			this.addBackground();
			this.displayFramerate();
		}
		
		private function init(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			this.flarManager = new FLARManager(configFile, new FLARToolkitManager(), this.stage);
			if (showSource) this.addSource();
			
			// Wrap up the handling of the marker events
			this.cardHandler = new CardHandler(this.cardFactory, this.flarManager);
			this.cardHandler.addEventListener(CardEvent.ADDED, this.cardAdded);
			this.cardHandler.addEventListener(CardEvent.REMOVED, this.cardRemoved);
			this.cardHandler.start();
		}
		
		private function cardAdded(event:CardEvent):void {
			this.addChild(event.card);
			this.cardsInPlay[event.card.id] = event.card;
			trace("Card", event.card.id,  "Added...");
		}
		
		private function cardRemoved(event:CardEvent):void {
			this.removeChild(event.card)
			delete this.cardsInPlay[event.card.id];
			trace("Card", event.card.id, "Removed...");
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