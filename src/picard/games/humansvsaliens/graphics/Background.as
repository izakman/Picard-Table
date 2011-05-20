package picard.games.humansvsaliens.graphics
{
	import away3dlite.cameras.Camera3D;
	import away3dlite.containers.Scene3D;
	import away3dlite.containers.View3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.hires.debug.Stats;
	
	public class Background extends Sprite {
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var view:View3D;
		
		private var _planet1:Planet;
		private var _planet2:Planet;
		
		public function Background() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			setup3DScene();
			setupPlanets();
			
			addChild(view);
			addChild(new Stats());
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function setup3DScene():void {
			view = new View3D();
			scene = new Scene3D();
			camera = new Camera3D();
			camera.z = -200;
			view.scene = scene;
			view.camera = camera;
			
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
		}
		
		private function setupPlanets():void {
			_planet1 = new Planet(Planet.HUMAN, false);
			_planet2 = new Planet(Planet.ALIEN, false);
			scene.addChild(_planet1);
			scene.addChild(_planet2);
		}
		
		public function get humanPlanet():Planet {
			return _planet1;
		}
		
		public function get alienPlanet():Planet {
			return _planet2;
		}
		
		private function onEnterFrame(e:Event):void {
			view.render();
		}
		
	}
}