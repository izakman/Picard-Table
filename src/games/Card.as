package games
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import games.timers.CardTimer;

	public class Card extends Sprite {
		
		protected var cardMarker:FLARMarker;
		protected var cardSprite:Sprite;
		
		protected var cardID:Number;
		protected var cardType:Number;
		
		public var isToBeRemoved:Boolean = false;
		public var removalTimer:CardTimer = null;
		public var placementTimer:CardTimer = null;
		
		public function Card(cardMarker:FLARMarker, cardID:Number) {
			this.cardMarker = cardMarker;
			this.cardID = cardID;
			this.updateLocation();
			this.addSprite();
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		public function replaceMarker(marker:FLARMarker):void {
			this.cardMarker = marker;
			//this.updateLocation();
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
		
		private function onRemoved(e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void {
			updateLocation();
		}
		
		private function updateLocation():void {
			this.x = this.cardMarker.centerpoint.x;
			this.y = this.cardMarker.centerpoint.y;
			this.rotation = this.cardMarker.rotationZ;
		}
		
		protected function addSprite():void {
			this.cardSprite = new Sprite();
			var pieceSize:int = 40;
			this.cardSprite.graphics.beginFill(0x00FF00);
			this.cardSprite.graphics.drawRoundRect(0, 0, pieceSize, pieceSize, 5);
			this.cardSprite.x = 0-(pieceSize/2);
			this.cardSprite.y = 0-(pieceSize/2);
			this.addChild(cardSprite);
		}
		
	}
}