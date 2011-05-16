package picard.games.humansvsaliens.cards
{
	import com.transmote.flar.marker.FLARMarker;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class PowerCard extends HVACard {
		
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
			this.updateLocation();
			this.checkProximity();
		}
		
		private function checkProximity():void {
			var gameCards:Dictionary = Global.vars.gameTable.cardsInPlay;
			for each (var card:HVACard in gameCards) {
				
			}
			
		}
		
	}
}