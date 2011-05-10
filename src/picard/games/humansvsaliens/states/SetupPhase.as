package picard.games.humansvsaliens.states
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import picard.GameState;
	import picard.events.StateEvent;
	
	public class SetupPhase extends GameState {
		
		private const PHASE_DURATION:Number = 2000;
		
		private var endPhaseTimer:Timer;
		
		public function SetupPhase() {
			this.endPhaseTimer = new Timer(PHASE_DURATION, 1);
			this.endPhaseTimer.addEventListener(TimerEvent.TIMER, phaseEnded);
		}
		
		private function phaseEnded(e:TimerEvent):void {
			this.dispatchEvent(new StateEvent(StateEvent.ENDED));
		}
	}
}