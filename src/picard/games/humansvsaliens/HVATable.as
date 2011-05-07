package picard.games.humansvsaliens
{
	import picard.GameTable;
	import picard.games.humansvsaliens.HVACardFactory;
	import picard.games.humansvsaliens.cards.HVACard;

	public class HVATable extends GameTable {
		
		public function HVATable() {
			this.cardFactory = new HVACardFactory();
			this.showSource = true;
			this.sourceAlpha = 1;
		}
		
		
	}
}