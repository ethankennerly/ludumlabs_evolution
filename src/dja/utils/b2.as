package dja.utils
{
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	
	public class b2
	{
		public static const BOX:String = "box";
		public static const CIRCLE:String = "circle";
		public static const POLYGON:String = "polygon";
		
		public static const DEG2RAD:Number = Math.PI/180;
		public static const RAD2DEG:Number = 180/Math.PI;
		
		public static const SQRT3:Number = Math.sqrt(3);
		public static const SQRT1_3:Number = 1/Math.sqrt(3);
		
		protected static const DEFAULT_BOUND:Number = 1000;		// pixels
		protected static const DEFAULT_GRAVITY:Number = 9.8;	// m/s^2
		protected static const DEFAULT_DRAW_SCALE:Number = 40;	// pixels/meter
		protected static const DEFAULT_DRAW_FLAGS:Number = b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit;
		
		protected static const DEFAULT_RADIUS:Number = 40;		// pixels
		protected static const DEFAULT_DENSITY:Number = 1;		// kg/m^2
		protected static const DEFAULT_FRICTION:Number = 0.5;
		protected static const DEFAULT_RESTITUTION:Number = 0.1;
		protected static const DEFAULT_DAMPING_RATIO:Number = 0.7;
		protected static const DEFAULT_VERTICES:Array = [ { x:0, y:-2*DEFAULT_RADIUS*SQRT1_3 }, { x:DEFAULT_RADIUS, y:DEFAULT_RADIUS*SQRT1_3 }, { x:-DEFAULT_RADIUS, y:DEFAULT_RADIUS*SQRT1_3 } ];
		
		protected static const bodyDef:b2BodyDef = new b2BodyDef();
		protected static const circleDef:b2CircleDef = new b2CircleDef();
		protected static const polygonDef:b2PolygonDef = new b2PolygonDef();
		protected static const distanceDef:b2DistanceJointDef = new b2DistanceJointDef();
		protected static const revoluteDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		protected static const prismaticDef:b2PrismaticJointDef = new b2PrismaticJointDef();
		protected static const mouseDef:b2MouseJointDef = new b2MouseJointDef();
		
		public static var drawScale:Number = DEFAULT_DRAW_SCALE;
		public static var computeBodyMass:Boolean = true;
		
		public static function world(paramHash:Object = null):b2World
		{
			var hash:Object = { lowerBoundX:-DEFAULT_BOUND,
								lowerBoundY:-DEFAULT_BOUND,
								upperBoundX:DEFAULT_BOUND,
								upperBoundY:DEFAULT_BOUND,
								gravityX:0,
								gravityY:DEFAULT_GRAVITY,
								doSleep:true,
								drawScale:drawScale,
								debugDrawSprite:null };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.x = hash.lowerBoundX*worldScale;
			aabb.lowerBound.y = hash.lowerBoundY*worldScale;
			aabb.upperBound.x = hash.upperBoundX*worldScale;
			aabb.upperBound.y = hash.upperBoundY*worldScale;
			
			var vec2_1:b2Vec2 = new b2Vec2(hash.gravityX, hash.gravityY);
			var world:b2World = new b2World(aabb, vec2_1, hash.doSleep);
			
			if (hash.debugDrawSprite) {
				
				world.m_debugDraw = debugDraw({ sprite:hash.debugDrawSprite, drawScale:hash.drawScale });
			}
			return world;
		}
		
		public static function debugDraw(paramHash:Object = null):b2DebugDraw
		{
			var hash:Object = { drawFlags:DEFAULT_DRAW_FLAGS,
								sprite:null,
								drawScale:drawScale,
								lineThickness:0,
								alpha:1,
								fillAlpha:0.3,
								xformScale:1 };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				//traceHash(hash);
			}
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.m_drawFlags = hash.drawFlags;
			debugDraw.m_sprite = hash.sprite;
			debugDraw.m_drawScale = hash.drawScale;
			debugDraw.m_lineThickness = hash.lineThickness;
			debugDraw.m_alpha = hash.alpha;
			debugDraw.m_fillAlpha = hash.fillAlpha;
			debugDraw.m_xformScale = hash.xformScale;
			
			return debugDraw;
		}
		
		public static function body(world:b2World, paramHash:Object = null):b2Body
		{
			var hash:Object = { centerOfMassX:0,
								centerOfMassY:0,
								mass:0,
								momentOfInertia:0,
								userData:null,
								x:0,
								y:0,
								angle:0,
								linearDamping:0,
								angularDamping:0,
								allowSleep:true,
								isSleeping:false,
								fixedRotation:false,
								isBullet:false,
								rotation:0,
								drawScale:drawScale,
								shapeParamArray:null,
								shapeParamHash:null };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				if ("rotation" in paramHash) {
					
					hash.angle = DEG2RAD*paramHash.rotation;
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			//var bodyDef:b2BodyDef = new b2BodyDef();
			
			bodyDef.massData.center.x = hash.centerOfMassX*worldScale;
			bodyDef.massData.center.y = hash.centerOfMassY*worldScale;
			bodyDef.massData.mass = hash.mass;
			bodyDef.massData.I = hash.momentOfInertia;
			bodyDef.userData = hash.userData;
			bodyDef.position.x = hash.x*worldScale;
			bodyDef.position.y = hash.y*worldScale;
			bodyDef.angle = hash.angle;
			bodyDef.linearDamping = hash.linearDamping;
			bodyDef.angularDamping = hash.angularDamping;
			bodyDef.allowSleep = hash.allowSleep;
			bodyDef.isSleeping = hash.isSleeping;
			bodyDef.fixedRotation = hash.fixedRotation;
			bodyDef.isBullet = hash.isBullet;
			
			var body:b2Body = world.CreateBody(bodyDef);
			
			if (hash.shapeParamArray is Array) {
				
				shapes(body, hash.shapeParamArray, hash.shapeParamHash);
				
				return body;
			}
			if (hash.shapeParamHash) {
				
				shape(body, hash.shapeParamHash);
				
				return body;
			}
			return body;
		}
		
		public static function circle(body:b2Body, paramHash:Object = null):b2CircleShape
		{
			var hash:Object = { x:0,
								y:0,
								radius:DEFAULT_RADIUS,
								userData:null,
								friction:DEFAULT_FRICTION,
								restitution:DEFAULT_RESTITUTION,
								density:DEFAULT_DENSITY,
								isSensor:false,
								categoryBits:0x0001,
								maskBits:0xFFFF,
								groupIndex:0,
								computeBodyMass:computeBodyMass,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			//var circleDef:b2CircleDef = new b2CircleDef();
			
			circleDef.localPosition.x = hash.x*worldScale;
			circleDef.localPosition.y = hash.y*worldScale;
			circleDef.radius = hash.radius*worldScale;
			circleDef.userData = hash.userData;
			circleDef.friction = hash.friction;
			circleDef.restitution = hash.restitution;
			circleDef.density = hash.density;
			circleDef.isSensor = hash.isSensor;
			circleDef.filter.categoryBits = hash.categoryBits;
			circleDef.filter.maskBits = hash.maskBits;
			circleDef.filter.groupIndex = hash.groupIndex;
			
			var circleShape:b2CircleShape = body.CreateShape(circleDef) as b2CircleShape;
			
			if (hash.computeBodyMass) {
				
				body.SetMassFromShapes();
			}
			return circleShape;
		}
		
		public static function box(body:b2Body, paramHash:Object = null):b2PolygonShape
		{
			var hash:Object = { width:2*DEFAULT_RADIUS,
								height:2*DEFAULT_RADIUS,
								x:0,
								y:0,
								angle:0,
								userData:null,
								friction:DEFAULT_FRICTION,
								restitution:DEFAULT_RESTITUTION,
								density:DEFAULT_DENSITY,
								isSensor:false,
								categoryBits:0x0001,
								maskBits:0xFFFF,
								groupIndex:0,
								computeBodyMass:computeBodyMass,
								rotation:0,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				if ("rotation" in paramHash) {
					
					hash.angle = DEG2RAD*paramHash.rotation;
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			//var polygonDef:b2PolygonDef = new b2PolygonDef();
			
			polygonDef.userData = hash.userData;
			polygonDef.friction = hash.friction;
			polygonDef.restitution = hash.restitution;
			polygonDef.density = hash.density;
			polygonDef.isSensor = hash.isSensor;
			polygonDef.filter.categoryBits = hash.categoryBits;
			polygonDef.filter.maskBits = hash.maskBits;
			polygonDef.filter.groupIndex = hash.groupIndex;
			
			if (hash.x == 0 &&
				hash.y == 0 &&
				hash.angle == 0) {
				
				polygonDef.SetAsBox(0.5*hash.width*worldScale, 0.5*hash.height*worldScale);
			} else {
				var vec2_1:b2Vec2 = new b2Vec2(hash.x*worldScale, hash.y*worldScale);
				
				polygonDef.SetAsOrientedBox(0.5*hash.width*worldScale, 0.5*hash.height*worldScale, vec2_1, hash.angle);
			}
			var polygonShape:b2PolygonShape = body.CreateShape(polygonDef) as b2PolygonShape;
			
			if (hash.computeBodyMass) {
				
				body.SetMassFromShapes();
			}
			return polygonShape;
		}
		
		public static function polygon(body:b2Body, paramHash:Object = null):b2PolygonShape
		{
			var hash:Object = { vertices:DEFAULT_VERTICES,
								userData:null,
								friction:DEFAULT_FRICTION,
								restitution:DEFAULT_RESTITUTION,
								density:DEFAULT_DENSITY,
								isSensor:false,
								categoryBits:0x0001,
								maskBits:0xFFFF,
								groupIndex:0,
								computeBodyMass:computeBodyMass,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			//var polygonDef:b2PolygonDef = new b2PolygonDef();
			
			polygonDef.userData = hash.userData;
			polygonDef.friction = hash.friction;
			polygonDef.restitution = hash.restitution;
			polygonDef.density = hash.density;
			polygonDef.isSensor = hash.isSensor;
			polygonDef.filter.categoryBits = hash.categoryBits;
			polygonDef.filter.maskBits = hash.maskBits;
			polygonDef.filter.groupIndex = hash.groupIndex;
			polygonDef.vertexCount = hash.vertices.length;
			
			var defVertex:b2Vec2;
			var hashVertex:Object;
			
			for (var index:int = 0; index < polygonDef.vertexCount; index++) {
				
				defVertex = polygonDef.vertices[index];
				hashVertex = hash.vertices[index];
				
				defVertex.x = hashVertex.x*worldScale || 0;
				defVertex.y = hashVertex.y*worldScale || 0;
			}
			var polygonShape:b2PolygonShape = body.CreateShape(polygonDef) as b2PolygonShape;
			
			if (hash.computeBodyMass) {
				
				body.SetMassFromShapes();
			}
			return polygonShape;
		}
		
		public static function shape(body:b2Body, paramHash:Object):b2Shape
		{
			if (paramHash &&
				"shape" in paramHash) {
				
				switch (paramHash.shape) {
					
					case BOX :
					//case "square" :
					//case "rectangle" :
						
						return box(body, paramHash);
						break;
					case CIRCLE :
						
						return circle(body, paramHash);
						break;
					case POLYGON :
						
						return polygon(body, paramHash);
						break;
					default :
						
						return null;
						trace("b2.shape, unknown shape: " + paramHash.shape);
						break;
				}
			} else {
				return null;
				trace("b2.shape, no shape");
			}
		}
		
		public static function shapes(body:b2Body, shapeParamArray:Array, shapeParamHash:Object = null):Array
		{
			var computeBodyMass:Boolean = b2.computeBodyMass;
			
			if (shapeParamHash &&
				"computeBodyMass" in shapeParamHash) {
				
				computeBodyMass = shapeParamHash.computeBodyMass;
			}
			var shapeCount:int = shapeParamArray.length;
			var shapeArray:Array = new Array();
			
			var paramHash:Object;
			var hash:Object;
			
			var prevComputeBodyMass:Boolean = b2.computeBodyMass;
			b2.computeBodyMass = false;
			
			for (var index:int = 0; index < shapeCount; index++) {
				
				paramHash = shapeParamArray[index];
				hash = null;
				
				if (shapeParamHash) {
					
					hash = new Object();
					
					for (var key:String in shapeParamHash) {
						
						hash[key] = shapeParamHash[key];
					}
					delete hash.computeBodyMass;
					
					if (paramHash) {
						
						for (key in paramHash) {
							
							hash[key] = paramHash[key];
						}
					}
				} else if (paramHash) {
					
					hash = paramHash;
				}
				shapeArray[index] = shape(body, hash);
			}
			if (computeBodyMass) {
				
				body.SetMassFromShapes();
			}
			b2.computeBodyMass = prevComputeBodyMass;
			
			return shapeArray;
		}
		
		public static function distanceJoint(body1:b2Body, body2:b2Body, paramHash:Object = null):b2DistanceJoint
		{
			var hash:Object = { x1:0,
								y1:0,
								x2:0,
								y2:0,
								length:NaN,
								userData:null,
								collideConnected:false,
								frequencyHz:1,
								dampingRatio:DEFAULT_DAMPING_RATIO,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			//var distanceDef:b2DistanceJointDef = new b2DistanceJointDef();
			
			var vec2_1:b2Vec2 = new b2Vec2(hash.x1*worldScale, hash.y1*worldScale);
			var vec2_2:b2Vec2 = new b2Vec2(hash.x2*worldScale, hash.y2*worldScale);
			
			distanceDef.Initialize(body1, body2, vec2_1, vec2_2);
			distanceDef.userData = hash.userData;
			distanceDef.collideConnected = hash.collideConnected;
			distanceDef.frequencyHz = hash.frequencyHz;
			distanceDef.dampingRatio = hash.dampingRatio;
			
			if (hash.length == hash.length) {//if (!isNaN(hash.length)) {
				
				distanceDef.length = hash.length*worldScale;
			}
			return body1.m_world.CreateJoint(distanceDef) as b2DistanceJoint;
		}
		
		public static function revoluteJoint(body1:b2Body, body2:b2Body, paramHash:Object = null):b2RevoluteJoint
		{
			var hash:Object = { x:0,
								y:0,
								userData:null,
								collideConnected:false,
								referenceAngle:NaN,
								lowerAngle:0,
								upperAngle:0,
								maxMotorTorque:0,
								motorSpeed:0,
								enableLimit:false,
								enableMotor:false,
								referenceRotation:NaN,
								lowerRotation:0,
								upperRotation:0,
								motorRotation:0,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				if ("lowerRotation" in paramHash) {
					
					hash.lowerAngle = DEG2RAD*paramHash.lowerRotation;
				}
				if ("upperRotation" in paramHash) {
					
					hash.upperAngle = DEG2RAD*paramHash.upperRotation;
				}
				if ("referenceRotation" in paramHash) {
					
					hash.referenceAngle = DEG2RAD*paramHash.referenceRotation;
				}
				if ("motorRotation" in paramHash) {
					
					hash.motorSpeed = DEG2RAD*paramHash.motorRotation;
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			//var revoluteDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			
			var vec2_1:b2Vec2 = new b2Vec2(hash.x*worldScale, hash.y*worldScale);
			
			revoluteDef.Initialize(body1, body2, vec2_1);
			revoluteDef.userData = hash.userData;
			revoluteDef.collideConnected = hash.collideConnected;
			revoluteDef.lowerAngle = hash.lowerAngle;
			revoluteDef.upperAngle = hash.upperAngle;
			revoluteDef.maxMotorTorque = hash.maxMotorTorque;
			revoluteDef.motorSpeed = hash.motorSpeed;
			revoluteDef.enableLimit = hash.enableLimit;
			revoluteDef.enableMotor = hash.enableMotor;
			
			if (hash.referenceAngle == hash.referenceAngle) {//if (!isNaN(hash.referenceAngle)) {
				
				revoluteDef.referenceAngle = hash.referenceAngle;
			}
			return body1.m_world.CreateJoint(revoluteDef) as b2RevoluteJoint;
		}
		
		public static function prismaticJoint(body1:b2Body, body2:b2Body, paramHash:Object = null):b2PrismaticJoint
		{
			var hash:Object = { x:0,
								y:0,
								axisX:1,
								axisY:0,
								userData:null,
								collideConnected:true,
								referenceAngle:NaN,
								lowerTranslation:-DEFAULT_RADIUS,
								upperTranslation:DEFAULT_RADIUS,
								maxMotorForce:0,
								motorSpeed:0,
								enableLimit:false,
								enableMotor:false,
								referenceRotation:NaN,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				if ("referenceRotation" in paramHash) {
					
					hash.referenceAngle = DEG2RAD*paramHash.referenceRotation;
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			//var prismaticDef:b2PrismaticJointDef = new b2PrismaticJointDef();
			
			var anchor:b2Vec2 = new b2Vec2(hash.x*worldScale, hash.y*worldScale);
			var axis:b2Vec2 = new b2Vec2(hash.axisX*worldScale, hash.axisY*worldScale);
			
			prismaticDef.Initialize(body1, body2, anchor, axis);
			prismaticDef.userData = hash.userData;
			prismaticDef.collideConnected = hash.collideConnected;
			prismaticDef.lowerTranslation = hash.lowerTranslation*worldScale;
			prismaticDef.upperTranslation = hash.upperTranslation*worldScale;
			prismaticDef.maxMotorForce = hash.maxMotorForce;
			prismaticDef.motorSpeed = hash.motorSpeed*worldScale;
			prismaticDef.enableLimit = hash.enableLimit;
			prismaticDef.enableMotor = hash.enableMotor;
			
			if (hash.referenceAngle == hash.referenceAngle) {//if (!isNaN(hash.referenceAngle)) {
				
				prismaticDef.referenceAngle = hash.referenceAngle;
			}
			return body1.m_world.CreateJoint(prismaticDef) as b2PrismaticJoint;
		}
		
		public static function mouseJoint(body:b2Body, paramHash:Object = null):b2MouseJoint
		{
			var hash:Object = { x:0,
								y:0,
								userData:null,
								collideConnected:true,
								maxForce:0,
								frequencyHz:5,
								dampingRatio:DEFAULT_DAMPING_RATIO,
								timeStep:1/30,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				//traceHash(hash);
			}
			var worldScale:Number = 1/hash.drawScale;
			//var mouseDef:b2MouseJointDef = new b2MouseJointDef();
			
			mouseDef.userData = hash.userData;
			mouseDef.collideConnected = hash.collideConnected;
			mouseDef.target.x = hash.x*worldScale;
			mouseDef.target.y = hash.y*worldScale;
			mouseDef.maxForce = hash.maxForce;
			mouseDef.frequencyHz = hash.frequencyHz;
			mouseDef.dampingRatio = hash.dampingRatio;
			mouseDef.timeStep = hash.timeStep;
			mouseDef.body1 = body.m_world.m_groundBody;
			mouseDef.body2 = body;
			
			return body.m_world.CreateJoint(mouseDef) as b2MouseJoint;
		}
		
		public static function room(body:b2Body, paramHash:Object = null):Object
		{
			var hash:Object = { width:550,
								height:400,
								x:NaN,
								y:NaN,
								wallThickness:DEFAULT_RADIUS,
								friction:DEFAULT_FRICTION,
								restitution:DEFAULT_RESTITUTION,
								isSensor:false,
								categoryBits:0x0001,
								maskBits:0xFFFF,
								groupIndex:0,
								computeBodyMass:false,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				//traceHash(hash);
			}
			if (hash.x != hash.x) {//if (isNaN(hash.x)) {
				
				hash.x = 0.5*hash.width;
			}
			if (hash.y != hash.y) {//if (isNaN(hash.y)) {
				
				hash.y = 0.5*hash.height;
			}
			//return shapes(body,
			//			  [	{ width:(hash.width + 2*hash.wallThickness), height:hash.wallThickness,					  x:hash.x,											 	y:(hash.y - 0.5*hash.height - 0.5*hash.wallThickness) },
			//				{ width:(hash.width + 2*hash.wallThickness), height:hash.wallThickness,					  x:hash.x,											 	y:(hash.y + 0.5*hash.height + 0.5*hash.wallThickness) },
			//				{ width:hash.wallThickness,					 height:(hash.height + 2*hash.wallThickness), x:(hash.x - 0.5*hash.width - 0.5*hash.wallThickness),	y:hash.y },
			//				{ width:hash.wallThickness,					 height:(hash.height + 2*hash.wallThickness), x:(hash.x + 0.5*hash.width + 0.5*hash.wallThickness), y:hash.y } ],
			//			  { shape:BOX, isSensor:hash.isSensor, categoryBits:hash.categoryBits, maskBits:hash.maskBits, groupIndex:hash.groupIndex, friction:hash.friction, restitution:hash.restitution, drawScale:hash.drawScale, computeBodyMass:hash.computeBodyMass });
			
			var shape:b2PolygonShape;
			var shapeHash:Object = new Object();
			
			shape = box(body, { isSensor:hash.isSensor, categoryBits:hash.categoryBits, maskBits:hash.maskBits, groupIndex:hash.groupIndex, friction:hash.friction, restitution:hash.restitution,
				width:(hash.width + 2*hash.wallThickness), height:hash.wallThickness, x:hash.x, y:(hash.y - 0.5*hash.height - 0.5*hash.wallThickness), drawScale:hash.drawScale, computeBodyMass:hash.computeBodyMass });
			shapeHash.top = shape;
			
			shape = box(body, { isSensor:hash.isSensor, categoryBits:hash.categoryBits, maskBits:hash.maskBits, groupIndex:hash.groupIndex, friction:hash.friction, restitution:hash.restitution,
				width:(hash.width + 2*hash.wallThickness), height:hash.wallThickness, x:hash.x, y:(hash.y + 0.5*hash.height + 0.5*hash.wallThickness), drawScale:hash.drawScale, computeBodyMass:hash.computeBodyMass });
			shapeHash.bottom = shape;
			
			shape = box(body, { isSensor:hash.isSensor, categoryBits:hash.categoryBits, maskBits:hash.maskBits, groupIndex:hash.groupIndex, friction:hash.friction, restitution:hash.restitution,
				width:hash.wallThickness, height:(hash.height + 2*hash.wallThickness), x:(hash.x - 0.5*hash.width - 0.5*hash.wallThickness), y:hash.y, drawScale:hash.drawScale, computeBodyMass:hash.computeBodyMass });
			shapeHash.left = shape;
			
			shape = box(body, { isSensor:hash.isSensor, categoryBits:hash.categoryBits, maskBits:hash.maskBits, groupIndex:hash.groupIndex, friction:hash.friction, restitution:hash.restitution,
				width:hash.wallThickness, height:(hash.height + 2*hash.wallThickness), x:(hash.x + 0.5*hash.width + 0.5*hash.wallThickness), y:hash.y, drawScale:hash.drawScale, computeBodyMass:hash.computeBodyMass });
			shapeHash.right = shape;
			
			return shapeHash;
		}
		
		public static function capsule(body:b2Body, paramHash:Object = null):Object
		{
			var hash:Object = { width:2*DEFAULT_RADIUS,
								height:4*DEFAULT_RADIUS,
								radius:DEFAULT_RADIUS,
								bumpHeight:0,
								x:0,
								y:0,
								angle:0,
								userData:null,
								friction:DEFAULT_FRICTION,
								restitution:DEFAULT_RESTITUTION,
								density:DEFAULT_DENSITY,
								isSensor:false,
								categoryBits:0x0001,
								maskBits:0xFFFF,
								groupIndex:0,
								computeBodyMass:computeBodyMass,
								rotation:0,
								drawScale:drawScale };
			if (paramHash) {
				
				for (var key:String in paramHash) {
					
					hash[key] = paramHash[key];
				}
				if ("rotation" in paramHash) {
					
					hash.angle = DEG2RAD*paramHash.rotation;
				}
				if ("radius" in paramHash) {
					
					hash.height = 2*hash.radius;
					
				} else if ("height" in paramHash) {
					
					hash.radius = 0.5*hash.height;
				}
				//traceHash(hash);
			}
			delete hash.rotation;
			
			var shapeHash:Object = new Object();
			var computeBodyMass:Boolean = hash.computeBodyMass;
			hash.computeBodyMass = false;
			
			hash.width = hash.width - 2*hash.radius;
			
			if (hash.bumpHeight > 0) {
				
				hash.vertices = [ { y:0.5*hash.height + hash.bumpHeight },   { x: -0.5*hash.width, y:0.5*hash.height }, { x: -0.5*hash.width, y: -0.5*hash.height },
								  { y: -0.5*hash.height - hash.bumpHeight }, { x:0.5*hash.width, y: -0.5*hash.height }, { x:0.5*hash.width, y:0.5*hash.height } ];
				
				shapeHash.middle = polygon(body, hash);
			} else {
				shapeHash.middle = box(body, hash);
			}
			var x:Number = hash.x, y:Number = hash.y;
			var sin:Number = 0.5*hash.width*Math.sin(hash.angle), cos:Number = 0.5*hash.width*Math.cos(hash.angle);
			
			hash.x = x - cos; hash.y = y - sin;
			shapeHash.left = circle(body, hash);
			
			hash.x = x + cos; hash.y = y + sin;
			shapeHash.right = circle(body, hash);
			
			if (computeBodyMass) {
				
				body.SetMassFromShapes();
			}
			return shapeHash;
		}
		
		public static function x(body:b2Body, drawScale:Number = NaN):Number
		{
			if (drawScale == drawScale) {
				
                return body.m_xf.position.x*drawScale;
			}
			return body.m_xf.position.x*b2.drawScale;
		}
		
		public static function y(body:b2Body, drawScale:Number = NaN):Number
		{
			if (drawScale == drawScale) {
				
                return body.m_xf.position.y*drawScale;
			}
			return body.m_xf.position.y*b2.drawScale;
		}
		
		public static function rotation(body:b2Body):Number
		{
			return RAD2DEG*body.m_sweep.a;
		}
		
		public static function distance(body1:b2Body, body2:b2Body, drawScale:Number = NaN):Number
		{
			if (drawScale != drawScale) {
				
				drawScale = b2.drawScale;
			}
			var position1:b2Vec2 = body1.m_xf.position, position2:b2Vec2 = body2.m_xf.position;
			var deltaX:Number = position2.x - position1.x, deltaY:Number = position2.y - position1.y;
			
			return Math.sqrt(deltaX*deltaX + deltaY*deltaY)*drawScale;
		}
		
		/*protected static function traceHash(hash:Object):void
		{
			for (var key:String in hash) {
				
				trace("key: " + key + ", value: " + hash[key]);
			}
		}*/
	}
}