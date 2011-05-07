package
{
	import flash.display.Sprite;
	
	import picard.GameTable;
	import picard.games.humansvsaliens.HVATable;
	
	[SWF(width="640", height="480", frameRate="30", backgroundColor="#000000")]
	public class PicardTable extends Sprite {
		
		public function PicardTable() {
			this.addChild(new HVATable());
		}
	}
}