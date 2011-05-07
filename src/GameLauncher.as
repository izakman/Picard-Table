package
{
	import flash.display.Sprite;
	
	import games.GameTable;
	import games.humansvsaliens.HVATable;
	
	[SWF(width="640", height="480", frameRate="30", backgroundColor="#000000")]
	public class GameLauncher extends Sprite {
		
		public function GameLauncher() {
			this.addChild(new HVATable());
		}
	}
}