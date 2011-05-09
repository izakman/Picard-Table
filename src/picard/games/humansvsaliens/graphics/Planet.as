package picard.games.humansvsaliens.graphics

{
	import picard.games.humansvsaliens.graphics.*;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.scenes.Scene3D;
	
	public class Planet extends DisplayObject3D
	{
		
		private var _source:String;
		private var _model:DAE;
		private var _rotationTimer:Timer = new Timer(30);
		
		public function Planet(source:String)
		{
			super();
			_source = source;
			setupPlanet();
			_rotationTimer.addEventListener(TimerEvent.TIMER,rotatePlanet);
			_rotationTimer.start();
		}
		
		private function rotatePlanet(e:TimerEvent):void {
			this.rotationX +=1;
			this.rotationY +=1;
			CAKE.renderEngine.render();
		}
		
		private function setupPlanet():void {
			_model = new DAE(true, "model", true);
			_model.load(_source);
			addChild(_model);
		}
		
		public function positionPlanet(planet:String):void {
			if(planet == "1") {
				_model.rotationX = 90;
				_model.rotationZ = -90;
				//_model.moveForward(12);
				_model.scale = 45;
				
				this.x = -119.052490234375;
				this.y = 0;
				this.z = 174.7154083251953;
				
			} else {
				_model.rotationX = 90;
				_model.rotationZ = -90;
				//_model.moveForward(12);
				_model.scale = 45;
				
				this.x = 119.052490234375;
				this.y = 0;
				this.z = 174.7154083251953;
			}
		}
	}
}