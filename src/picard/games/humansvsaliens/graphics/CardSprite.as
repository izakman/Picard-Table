package picard.games.humansvsaliens.graphics
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.MovieClipLoaderAsset;
	
	import picard.games.humansvsaliens.Side;
	import picard.games.humansvsaliens.cards.HVACard;
	
	public class CardSprite extends Sprite {
		
		private const SIZE:int = 100;
		
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
		private var _tweenPoints:Array;
		private var _currentTweenPoint:Point;
		private var _timeline:TimelineMax;
		private var _tween:TweenMax;
		
		public function CardSprite(card:HVACard) {
			switch (card.type) {
				case 0: _sprite = (card.side == Side.HUMAN) ? new HumanScout() : new AlienScout(); break;
				case 1: _sprite = (card.side == Side.HUMAN) ? new HumanFighter() : new AlienFighter(); break;
				case 2: _sprite = (card.side == Side.HUMAN) ? new HumanDefender() : new AlienDefender(); break;
				case 3: _sprite = new PowerBoost1(); break;
				case 4: _sprite = new PowerBoost2(); break;
			}
			_sprite.addEventListener(Event.COMPLETE, spriteLoaded);
			addBorder();
		}
		
		private function spriteLoaded(e:Event):void {
			trace("     -- Card sprite loaded");
			_sprite.x = (SIZE/2) - (_sprite.width/2);
			_sprite.y = (SIZE/2) - (_sprite.height/2);
			
			setupTweenPoints();
			setupSpriteAnimation();
			setNewTweenPoint();
			
			_timeline.play();
			this.addChild(_sprite);
		}
		
		private function setupTweenPoints():void {
			_currentTweenPoint = new Point(_sprite.x, _sprite.y);
			_tweenPoints = [ new Point(_sprite.x,	 _sprite.y-6), 
							 new Point(_sprite.x+4,	 _sprite.y-4), 
							 new Point(_sprite.x+6,  _sprite.y), 
							 new Point(_sprite.x+4,	 _sprite.y+4), 
							 new Point(_sprite.x,	 _sprite.y+6), 
							 new Point(_sprite.x-4,	 _sprite.y+4), 
							 new Point(_sprite.x-6,  _sprite.y), 
							 new Point(_sprite.x-4,	 _sprite.y-4) ];
		}
		
		private function setNewTweenPoint():void {
			_sprite.x = _currentTweenPoint.x;
			_sprite.y = _currentTweenPoint.y;
			_currentTweenPoint = _tweenPoints[Math.floor(Math.random() * 8)];
			_tween.updateTo({x:_currentTweenPoint.x, y:_currentTweenPoint.y}, true);
		}
		
		private function setupSpriteAnimation():void {
			_timeline = new TimelineMax({repeat:-1, onRepeat:setNewTweenPoint});
			_tween = new TweenMax(_sprite, 4, {x:_currentTweenPoint.x, y:_currentTweenPoint.y, ease:Sine.easeInOut});
			_timeline.insert(_tween);
			_timeline.stop();
		}
		
		private function addBorder():void {
			var border:Sprite = new Sprite();
			border.graphics.lineStyle(1, 0x0000FF, 0.2);
			border.graphics.drawRect(0, 0, SIZE, SIZE);
			this.addChild(border);
		}
		
	}
}