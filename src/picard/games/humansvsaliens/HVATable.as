package picard.games.humansvsaliens
{
	import flash.utils.Dictionary;
	
	import picard.GameTable;
	import picard.events.StateEvent;
	import picard.games.humansvsaliens.HVACardFactory;
	import picard.games.humansvsaliens.cards.HVACard;
	import picard.games.humansvsaliens.states.SetupPhase;

	/**
	 * The GameTable for the Humans vs Aliens card game.
	 */
	public class HVATable extends GameTable {
		
		public static const PLANET_HEALTH:Number = 20;
		
		protected var player1:Player;
		protected var player2:Player;
		
		private var planetHealth:Dictionary;
		
		public function HVATable() {
			this.cardFactory = new HVACardFactory();
			this.showSource = true;
			this.sourceAlpha = 1;
			
			this.player1 = new Player(Side.HUMAN);
			this.player2 = new Player(Side.ALIEN);
			this.planetHealth = new Dictionary();
			this.planetHealth[player1] = PLANET_HEALTH;
			this.planetHealth[player2] = PLANET_HEALTH;
		}
		
//		override protected function startGame():void {
//			var setupPhase:SetupPhase = new SetupPhase();
//			setupPhase.addEventListener(StateEvent.ENDED, enterCommandPhase);
//		}
		
		private function enterCommandPhase(e:StateEvent):void {
			//TODO: enterCommandPhase
		}
		
		private function enterBattlePhase(e:StateEvent):void {
			//TODO: enterBattlePhase
		}
		
		private function enterInvasionPhase(e:StateEvent):void {
			//TODO: enterBattlePhase
			this.checkForWinner();
		}
		
		private function checkForWinner():void {
			//TODO: enterBattlePhase
		}
		
		override protected function endGame():void {
			//TODO: endGame
		}
		
	}
}