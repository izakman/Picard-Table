package picard
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	
	import picard.timers.CardTimer;

	public class Card extends Sprite {
		
		//private const GLITCH_RADIUS:Number = 50;
		
		protected var cardMarker:FLARMarker;
		protected var cardSprite:DisplayObject;
		
		protected var cardID:Number;
		protected var cardType:Number;
		protected var cardSide:String;
		
		public var isToBeRemoved:Boolean = false;
		public var removalTimer:CardTimer = null;
		public var placementTimer:CardTimer = null;
		
		public function Card(cardMarker:FLARMarker, cardID:Number) {
			this.cardMarker = cardMarker;
			this.cardID = cardID;
			this.cardType = cardMarker.patternId;
			this.updateLocation();
			this.cardSide = this.determinSide();
			
			//this.drawCard();
			this.addEventListener(Event.ENTER_FRAME, this.enterFrame);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.cleanUp);
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
		}
		
		public function replaceMarker(marker:FLARMarker):void {
			this.cardMarker = marker;
			//TODO: Add a tranistion to the new marker
		}
		
		public function get marker():FLARMarker {
			return this.cardMarker;
		}
		
		public function get type():Number {
			return this.cardType;
		}
		
		public function get id():Number {
			return this.cardID;
		}
		
		public function get side():String {
			return this.cardSide;
		}
		
		protected function enterFrame(e:Event):void {
			//if (!hasMarkerGlitched()) {
				updateLocation();
			//}
		}
		
		protected function updateLocation():void {
			this.x = this.cardMarker.centerpoint.x;
			this.y = this.cardMarker.centerpoint.y;
			this.rotation = this.cardMarker.rotationZ;
		}
		
		protected function determinSide():String {
			if (this.x < GameTable.TABLE_WIDTH/2) {
				return "left";
			} else {
				return "right";
			}
		}
		
		protected function drawCard():void {
			var sprite:Sprite = new Sprite();
			var pieceSize:int = 40;
			sprite.graphics.beginFill(0x00FF00);
			sprite.graphics.drawRoundRect(0, 0, pieceSize, pieceSize, 5);
			sprite.x = 0-(pieceSize/2);
			sprite.y = 0-(pieceSize/2);
			this.cardSprite = sprite;
			this.addChild(this.cardSprite);
		}
		
		protected function addedToStage(e:Event):void {
			drawCard();
		}
		
		public function cleanUp(e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function hasMarkerGlitched():Boolean {
			return false;
		}
		
	}
}