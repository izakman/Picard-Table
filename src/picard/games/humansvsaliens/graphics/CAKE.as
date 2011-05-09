
package picard.games.humansvsaliens.graphics {
	import com.transmote.flar.FLARManager;
	import com.transmote.flar.camera.FLARCamera_PV3D;
	import com.transmote.flar.marker.FLARMarker;
	import com.transmote.flar.marker.FLARMarkerEvent;
	import com.transmote.flar.tracker.FLARToolkitManager;
	import com.transmote.flar.utils.geom.PVGeomUtils;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	//import net.eriksjodin.arduino.Arduino;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.render.LazyRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	/**
	 * FLARManager_Tutorial3D demonstrates how to display a Collada-formatted model
	 * using FLARManager, FLARToolkit, and Papervision3D. 
	 * see the accompanying tutorial writeup here:
	 * http://words.transmote.com/wp/flarmanager/inside-flarmanager/loading-collada-models/
	 * 
	 * Modified by Mark Readman s4200092
	 * 
	 */
	public class CAKE extends Sprite {
		
		
		
		
		static public var renderEngine:LazyRenderEngine;
		
		
		private var flarManager:FLARManager;
		
		private var scene3D:Scene3D;
		private var camera3D:Camera3D;
		private var viewport3D:Viewport3D;
		//private var renderEngine:LazyRenderEngine;
		private var pointLight3D:PointLight3D;
		
		private var activeMarker:FLARMarker;
		private var modelContainer:DisplayObject3D;
		///////////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////
		//My planet vars
		private var p1Con:Planet;
		private var p2Con:Planet;
		private var p2dmgCon:Planet;
		private var p1dmgCon:Planet;
		//private var arduino:Arduino;//Arduino connection test
		//Space BG
		//private var spaceBG:Plane;
		
		
		//from http://paranoidart.com/showcase/papervision3d/001/srcview/index.html
		private var rotP1:Number = 0;
		private var rotP2:Number = 0;
		///////////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////
		
		//////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////
		//Add images
		[Embed(source="../resources/assets/s21.png")]
		public var shipClass:Class;
		private var ship:Bitmap = new shipClass ();
		
		
		
		
		//[Embed(source="../resources/assets/s21.png")]
		//private var Ship:Class;
		//[Embed(source="../resources/assets/s22.png")]
		//private var Ship2:Class;
		//[Embed(source="../resources/assets/s23.png")]
		//private var Ship3:Class;
		
		
		
		public function CAKE () {
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
		}
		
		private function onAdded (evt:Event) :void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
			
			// pass the path to the FLARManager xml config file into the FLARManager constructor.
			// FLARManager creates and uses a FLARCameraSource by default.
			// the image from the first detected camera will be used for marker detection.
			// also pass an IFLARTrackerManager instance to communicate with a tracking library,
			// and a reference to the Stage (required by some trackers).
			
			this.flarManager = new FLARManager("../resources/flarConfig.xml", new FLARToolkitManager(), this.stage);
			
			// to switch tracking engines, pass a different IFLARTrackerManager into FLARManager.
			// refer to this page for information on using different tracking engines:
			// http://words.transmote.com/wp/inside-flarmanager-tracking-engines/
			//			this.flarManager = new FLARManager("../resources/flar/flarConfig.xml", new FlareManager(), this.stage);
			//			this.flarManager = new FLARManager("../resources/flar/flarConfig.xml", new FlareNFTManager(), this.stage);
			
			// add FLARManager.flarSource to the display list to display the video capture.
			this.addChild(Sprite(this.flarManager.flarSource));
			
			// begin listening for FLARMarkerEvents.
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_ADDED, this.onMarkerAdded);
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_UPDATED, this.onMarkerUpdated);
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_REMOVED, this.onMarkerRemoved);
			
			// wait for FLARManager to initialize before setting up Papervision3D environment.
			this.flarManager.addEventListener(Event.INIT, this.onFlarManagerInited);
		}
		
		private function onFlarManagerInited (evt:Event) :void {
			this.flarManager.removeEventListener(Event.INIT, this.onFlarManagerInited);
			
			this.scene3D = new Scene3D();
			this.viewport3D = new Viewport3D(this.stage.stageWidth, this.stage.stageHeight);
			this.addChild(this.viewport3D);
			
			this.camera3D = new FLARCamera_PV3D(this.flarManager, new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight));
			
			CAKE.renderEngine = new LazyRenderEngine(this.scene3D, this.camera3D, this.viewport3D);
			
			
			
			
			
			
			this.pointLight3D = new PointLight3D();
			this.pointLight3D.x = 1000;
			this.pointLight3D.y = 1000;
			this.pointLight3D.z = -1000;
			
			// load the model.
			// (this model has to be scaled and rotated to fit the marker; every model is different.)
			var model:DAE = new DAE(true, "model", true);
			model.load("../resources/assets/planet2_dam.dae");
			model.rotationX = 90;
			model.rotationZ = -90;
			model.scale = 10;
			
			
			
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//Marks section
			//Planet testing (non marker tracking) PLANET 1
			var p1source:String　= "../resources/assets/planet1.dae";
			this.p1Con = new Planet(p1source);
			p1Con.positionPlanet("1");
			this.scene3D.addChild(this.p1Con);
			
			
			/////////////////////////////
			//////////////////////////////
			//Testing sprite import
			
			//var x:String = Ship.toString();
			trace("["+ this.ship +"] asjtfhalskfbaslkfhasl");
			
			
			//Damaged version of planet 1
			var p1dmgsource:String　= "../resources/assets/planet1_dam.dae";
			this.p1dmgCon = new Planet(p1dmgsource);
			p1dmgCon.positionPlanet("1");
			this.scene3D.addChild(this.p1dmgCon);
			this.p1dmgCon.visible = false;
			
			
			
			
			var s:Plane=new Plane (new ColorMaterial(0x000000),2000,2000,5,5);
			s.x = 0;
			s.y = 0;
			s.z = 2000;//About 800 is 40ish cm from camera
			//s.alpha = 0.1;//Didnt work
			this.scene3D.addChild(s);
			//var col:MaterialObject3D = new MaterialObject3D();
			/////////////////////////////////////////
			//Cant figure out how to add material to see it...
			//
			//var space3D:Plane = new Plane(col, 1000, 1000);
			//space3D.x = 0;
			//space3D.y = 0;
			//space3D.z = 100;
			//this.scene3D.addChild(space3D);
			
			/////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////
			//Arduino stuff here
			
			//arduino = new Arduino("127.0.0.1", 5331); 
			//arduino.setPinMode(13, Arduino.OUTPUT); 
			
			
			
			
			//this.p1Con = new Planet();
			//this.p1Con.addChild(p1);
			//this.scene3D.addChild(this.p1Con);
			
			//Planet testing (non marker tracking) PLANET 2
			var p2source:String　= "../resources/assets/planet2.dae";
			
			this.p2Con = new Planet(p2source);
			p2Con.positionPlanet("2");
			this.scene3D.addChild(this.p2Con);
			
			//Damaged version of planet 2
			var p2dmgsource:String　= "../resources/assets/planet2_dam.dae";
			this.p2dmgCon = new Planet(p2dmgsource);
			p2dmgCon.positionPlanet("2");
			this.scene3D.addChild(this.p2dmgCon);
			this.p2dmgCon.visible = false;
			
			
			
			//Make planets rotate constantly
			//from http://paranoidart.com/showcase/papervision3d/001/srcview/index.html
			
			
			
			//Make planets change skin/model on hit (mouse click for now?)
			
			
			
			//refresh scene (for when a new game is started)
			
			
			
			
			
			
			
			
			
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////////////////////////////////////
			
			// create a container for the model, that will accept matrix transformations.
			this.modelContainer = new DisplayObject3D();
			this.modelContainer.addChild(model);
			this.modelContainer.visible = false;
			this.scene3D.addChild(this.modelContainer);
			this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		}
		
		private function onMarkerAdded (evt:FLARMarkerEvent) :void {
			trace("["+evt.marker.patternId+"] added");
			this.modelContainer.visible = true;
			this.activeMarker = evt.marker;
			//////////////////////////////////////////////
			//////////////////////////////////////////////
			//Test changing object
			this.p2dmgCon.visible = true;
			this.p2Con.visible = false;
			this.p1dmgCon.visible = true;
			this.p1Con.visible = false;
			//this.arduino.writeDigitalPin(13, Arduino.HIGH);
		}
		
		private function onMarkerUpdated (evt:FLARMarkerEvent) :void {
			//trace("["+evt.marker.patternId+"] updated");
			this.modelContainer.visible = true;
			this.activeMarker = evt.marker;
			
		}
		
		private function onMarkerRemoved (evt:FLARMarkerEvent) :void {
			trace("["+evt.marker.patternId+"] removed");
			this.modelContainer.visible = false;
			this.activeMarker = null;
			//////////////////////////////////////////////
			//////////////////////////////////////////////
			//Test changing object
			this.p2dmgCon.visible = false;
			this.p2Con.visible = true;
			this.p1dmgCon.visible = false;
			this.p1Con.visible = true;
			
			//this.arduino.writeDigitalPin(13, Arduino.LOW);
		}
		
		private function onEnterFrame (evt:Event) :void {
			// apply the FLARToolkit transformation matrix to the Cube.
			if (this.activeMarker) {
				this.modelContainer.transform = PVGeomUtils.convertMatrixToPVMatrix(this.activeMarker.transformMatrix);
			}
			//trace(this.modelContainer.x,this.modelContainer.y,this.modelContainer.z);
			//trace("*"+this.modelContainer.scaleX,this.modelContainer.scaleY,this.modelContainer.scaleZ);
			// update the Papervision3D view.
			CAKE.renderEngine.render();
		}
		
		/////////////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////////////
		
	}
}