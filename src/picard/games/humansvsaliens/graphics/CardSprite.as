package picard.games.humansvsaliens.graphics
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.core.MovieClipLoaderAsset;
	
	import picard.games.humansvsaliens.Side;
	import picard.games.humansvsaliens.cards.HVACard;
	
	public class CardSprite extends Sprite {
		
		private const SIZE:Number = 100;
		
		[Embed(source="resources/humansvsaliens/assets/cards/power_boost_1.swf")]
		private var PowerBoost1:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cards/power_boost_2.swf")]
		private var PowerBoost2:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cards/human_scout.swf")]
		private var HumanScout:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cards/human_fighter.swf")]
		private var HumanFighter:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cards/human_defender.swf")]
		private var HumanDefender:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cards/alien_scout.swf")]
		private var AlienScout:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cards/alien_fighter.swf")]
		private var AlienFighter:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cards/alien_defender.swf")]
		private var AlienDefender:Class;
			//_sprite.addEventListener(Event.COMPLETE, spriteLoaded);
			
		
		private var _sprite:MovieClipLoaderAsset;
		
		public function CardSprite(card:HVACard) {
			
			switch (card.type) {
				case 0: _sprite = (card.side == Side.HUMAN) ? new HumanScout() : new AlienScout(); break;
				case 1: _sprite = (card.side == Side.HUMAN) ? new HumanFighter() : new AlienFighter(); break;
				case 2: _sprite = (card.side == Side.HUMAN) ? new HumanDefender() : new AlienDefender(); break;
				case 3: _sprite = new PowerBoost1(); break;
				case 4: _sprite = new PowerBoost2(); break;
			}
			
			var border:Sprite = new Sprite();
			border.graphics.lineStyle(1, 0x0000FF, 0.2);
			border.graphics.drawRect(0, 0, SIZE, SIZE);
			this.addChild(border);
			
			_sprite.addEventListener(Event.COMPLETE, spriteLoaded);
		}
		
		private function spriteLoaded(e:Event):void {
			trace("     -- Card sprite loaded");
			_sprite.x = (SIZE/2) - (_sprite.width/2);
			_sprite.y = (SIZE/2) - (_sprite.height/2);
			this.addChild(_sprite);
		}
		
	}
}