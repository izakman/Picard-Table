package picard.games.humansvsaliens
{
	public class Side {
		
		public static const HUMAN:Side = new Side("human");
		public static const ALIEN:Side = new Side("alien");
		
		private var _value:String;
		
		public function Side(value:String) {
			this._value = value;
		}
		
		public function toString():String {
			return this._value;
		}
		
		public function get value():String {
			return this._value;
		}
	}
}