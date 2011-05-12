package {
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	
	import picard.GameTable;
	import picard.games.humansvsaliens.HVATable;
	import picard.games.humansvsaliens.graphics.CAKE;
	
	[SWF(width="960", height="600", frameRate="30", backgroundColor="#000000")]
	public class PicardTable_AIR extends Sprite {
		
		public function PicardTable_AIR () {
						
			this.addChild(new HVATable());
			
		}
		
	}
}