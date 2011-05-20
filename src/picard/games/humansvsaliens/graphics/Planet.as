package picard.games.humansvsaliens.graphics
{
	import away3dlite.core.utils.Cast;
	import away3dlite.materials.BitmapMaterial;
	import away3dlite.materials.Material;
	import away3dlite.primitives.Sphere;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Planet extends Sphere {
		
		public static const HUMAN:String = "left";
		public static const ALIEN:String = "right";
		
		[Embed(source="resources/humansvsaliens/assets/earth512.png")]
		private var humanBitmap:Class;
		
		[Embed(source="resources/humansvsaliens/assets/earth512.png")]
		private var humanDamBitmap:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cracks.jpg")]
		private var alienBitmap:Class;
		
		[Embed(source="resources/humansvsaliens/assets/cracks.jpg")]
		private var alienDamBitmap:Class;
		
		private const SEGMENTS_WIDTH:Number = 64;
		private const SEGMENTS_HIGHT:Number = 32;
		private const RADIUS:Number = 150;
		
		private const ROTATION_SPEED:Number = 30;
		private const POSITION_FROM_CENTRE:Number = 280;
		//private const POSITION_DEPTH:Number = 280;
		
		private var _material:BitmapMaterial;
		private var _type:String;
		private var _damaged:Boolean;
		private var _rotationTimer:Timer;
		
		public function Planet(type:String, damaged:Boolean) {
			_type = type;
			_damaged = damaged;
			this.setMaterial();
			this.radius = RADIUS;
			this.segmentsW = SEGMENTS_WIDTH;
			this.segmentsH = SEGMENTS_HIGHT;
			
			this.positionPlanet();
			_rotationTimer = new Timer(ROTATION_SPEED);
			_rotationTimer.addEventListener(TimerEvent.TIMER, rotatePlanet);
			_rotationTimer.start();
		}
		
		private function setMaterial():void {
			var texture:Class;
			if (_type == HUMAN) {
				if (_damaged) {
					texture = humanDamBitmap;
				} else {
					texture = humanBitmap;
				}
			} else {
				if (_damaged) {
					texture = alienDamBitmap;
				} else {
					texture = alienBitmap;
				}
			}
			this.material = new BitmapMaterial(Cast.bitmap(texture));
		}
		
		private function positionPlanet():void {
			if(_type == HUMAN) {
				this.x = -POSITION_FROM_CENTRE;
			} else {
				this.x = POSITION_FROM_CENTRE;
			}
		}
		
		private function rotatePlanet(e:Event):void  {
			this.rotationX += 0.1;
			this.rotationZ += 0.1;
		}
		
	}
}