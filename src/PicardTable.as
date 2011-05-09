package
{
	import flash.display.Sprite;
	
	import picard.GameTable;
	import picard.games.humansvsaliens.HVATable;
	import picard.games.humansvsaliens.graphics.CAKE;
	
	[SWF(width="960", height="600", frameRate="30", backgroundColor="#000000")]
	public class PicardTable extends Sprite {
		
		public function PicardTable() {
			//this.addChild(new HVATable());
			this.addChild(new CAKE());
		}
	}
}