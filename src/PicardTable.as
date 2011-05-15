package {
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	
	import picard.GameTable;
	import picard.games.humansvsaliens.HVATable;
	import picard.games.humansvsaliens.graphics.CAKE;
	
	[SWF(width="960", height="600", frameRate="30", backgroundColor="#000000")]
	/**
	 * The launcher and loading screen, the entry point into the program. 
	 * Games are loaded by instantiating a subclass of GameTable and adding it
	 * to the stage here.
	 * 
	 */
	public class PicardTable extends Sprite {
		
		private var isFullscreen:Boolean = false;
		
		public function PicardTable () {
			
			this.addChild(new HVATable());
			//this.addChild(new CAKE());
			stage.addEventListener(MouseEvent.CLICK, toggleFullscreen);
		}
		
		private function toggleFullscreen(e:MouseEvent):void {
			if (isFullscreen) {
				stage.displayState = StageDisplayState.NORMAL;
			} else {
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			this.isFullscreen = !this.isFullscreen;
		}
		
	}
}