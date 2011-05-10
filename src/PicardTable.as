package
{
	import flash.display.Sprite;
	
	import picard.GameTable;
	import picard.games.humansvsaliens.HVATable;
	
	[SWF(width="640", height="480", frameRate="30", backgroundColor="#000000")]
	/**
	 * The launcher and loading screen, the entry point into the program. 
	 * Games are loaded by instantiating a subclass of GameTable and adding it
	 * to the stage here.
	 * 
	 */
	public class PicardTable extends Sprite {
		
		private var currentTable:GameTable;
		
		public function PicardTable() {
			this.loadHVA();
		}
		
		private function loadLoader():void {
			// addChild loader
		}
		
		private function loadHVA():void {
			this.currentTable = new HVATable();
			this.addChild(this.currentTable);
		}
	}
}