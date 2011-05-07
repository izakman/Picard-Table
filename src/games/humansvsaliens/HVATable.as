package games.humansvsaliens
{
	import games.GameTable;
	import games.humansvsaliens.HVACardFactory;
	import games.humansvsaliens.cards.HVACard;

	public class HVATable extends GameTable {
		
		public function HVATable() {
			this.cardFactory = new HVACardFactory();
			this.showSource = true;
			this.sourceAlpha = 1;
		}
		
		
	}
}