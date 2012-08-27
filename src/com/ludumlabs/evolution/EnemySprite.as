package com.ludumlabs.evolution
{
    import dja.utils.b2;
    import Box2D.Dynamics.b2World;
    import Box2D.Dynamics.b2Body;
    import Box2D.Collision.Shapes.b2MassData;
    import Box2D.Common.Math.b2Vec2;
    
    import org.flixel.*;

    public class EnemySprite extends FlxSprite
    {
        /** 
         * Currently speed 5 to 80 shows no effect on enemy speed. 
         */
        public static var player:PlayerSprite;
        public static var replayers:FlxGroup;
        public static var tilemap:FlxTilemap;
        
        protected static const PATHFINDING_VARIANCE = 0.4;
        protected static const PF_FOLLOW = 0;
        protected static const PF_GUESS = 1;
        protected static const BLIND_FOLLOW_WIGGLE_ROOM = 4;
        
        protected static const BASE_SPEED:Number = 50;
        protected static const SPEED_VARIANCE:Number = 20;
        
        public var pfState:Number = PF_GUESS;
        public var pathTimer:Number = 0;
        
        public var body:b2Body;
        public var tempVec:b2Vec2;
        public var speed:Number = 60;
        public var bodyMass:Number = 1;
        public var maxImpulse:Number = 1;
        
        protected var pathfindingDelay:Number = 150;
        protected var tryPathfinding:Boolean = true;

        /**
         * Load sprite sheet and position at center of image.
         */
        public function EnemySprite(X:int = 0, Y:int = 0, SimpleGraphic:Class = null)
        {
            super(X, Y);
            
            speed = BASE_SPEED + FlxG.random()*SPEED_VARIANCE;
            
            var sheet:EnemySpriteSheet = new EnemySpriteSheet();
            loadGraphic(EnemySpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            offset.x = frameWidth * 0.5;
            offset.y = frameHeight * 0.5;
            centerOffsets();

            drag.x = speed * 8;
            maxVelocity.x = speed;
            maxVelocity.y = speed;
            
            health = 3;
            
            tempVec = new b2Vec2();
        }
        
        override public function kill():void
        {
            FlxG.play(Sounds.Kill);
            super.kill();
            
            body.m_world.DestroyBody(body);
            body = null;
        }
        
        public function initPhysics(world:b2World):void
        {
            body = b2.body(world, { x:x + 0.5*width, y:y + 0.5*height });
            
            b2.box(body, { width:0.85*width, height:0.85*height, rotation:FlxG.random()*360, friction:0, computeBodyMass:false });
            b2.circle(body, { radius:0.5*width, friction:0, computeBodyMass:false });
            
            var massData:b2MassData = new b2MassData();
            massData.mass = bodyMass;
            
            body.SetMass(massData);
        }
        
        public function resetTimer():void
        {
            pathTimer = Math.floor( Math.random()*(pathfindingDelay*PATHFINDING_VARIANCE) + (pathfindingDelay*(1-PATHFINDING_VARIANCE)) );
        }
        
		override protected function updateMotion():void
		{
			tempVec.x = velocity.x/b2.drawScale;    // target world velocity
			tempVec.y = velocity.y/b2.drawScale;    //
            
            tempVec.x = bodyMass*(tempVec.x - body.m_linearVelocity.x);    // target impulse
            tempVec.y = bodyMass*(tempVec.y - body.m_linearVelocity.y);    //
            
            var length:Number = tempVec.Length();
            
            if (length > maxImpulse) {
                
                tempVec.x = maxImpulse*tempVec.x/length;    // clamp impulse to maxImpulse
                tempVec.y = maxImpulse*tempVec.y/length;    //
            }
            body.ApplyImpulse(tempVec, body.m_xf.position);
            
			x = b2.x(body) - 0.5*width;
			y = b2.y(body) - 0.5*height;
		}
        
        public function getTarget():PlayerSprite
        {
            var index:Number = -1;
            var tmp:Number;
            var minDist:Number = Math.abs(x - player.x) + Math.abs(y - player.y);
            var bestTarget:PlayerSprite = player; //start with the current player since we know they're alive
            
            while (replayers.members.length > (++index)) {
                if (replayers.members[index].alive) {                
                    tmp = Math.abs(x - replayers.members[index].x) + Math.abs(y - replayers.members[index].y)
                    if (tmp < minDist) {
                        minDist = tmp;
                        bestTarget = replayers.members[index];
                    }
                }
            }
            
            return bestTarget;
        }
        
        public function pathfind():void
        {
            var path:FlxPath;
            var dest:FlxPoint;
            var target:PlayerSprite = getTarget();
            
            if (tryPathfinding && pathTimer <= 0) {
                resetTimer();
                path = tilemap.findPath(new FlxPoint(x + width / 2, y + height / 2), getDestination(target));
                if(path) {
                    pfState = PF_FOLLOW;
                    followPath(path, speed);
                } else {
                    stopFollowingPath();
                    pfState = PF_GUESS;
                }
            }
            
            if (pfState == PF_GUESS) {
                blindFollow(target);
            }
        }
        
        public function getDestination(target:PlayerSprite):FlxPoint
        {
            //var dist:Number = Math.sqrt(Math.pow((x - getTarget().x), 2) + Math.pow((y - getTarget().y), 2))
            //TODO: use non-euclidian distance if we have extra cycles, though euclidian may be more appropriate given that diagonal is faster
            
            var dist:Number = Math.abs(x - target.x) + Math.abs(y - target.y);
            
            //TODO: replace Math.random() with a zombie-specific coefficient if we want that behavior
            var destX:Number = target.velocity.x * Math.sqrt(dist) / 8 * Math.random() + target.x;
            var destY:Number = target.velocity.y * Math.sqrt(dist) / 8 * Math.random() + target.y;
            var bounds:FlxRect = tilemap.getBounds();
            if (destX < bounds.right && destX > bounds.left && destY < bounds.bottom && destY > bounds.top) {
                return new FlxPoint(destX, destY);
            } else {
                // Player is too close to the edge to lead, just return the player's current coords
                return new FlxPoint(target.x, target.y);
            }
            
        }
        
        public function blindFollow(target:PlayerSprite):void
        {
            velocity.x = 0;
            velocity.y = 0;
            if (target.x !== undefined) {
                if (target.x < x - BLIND_FOLLOW_WIGGLE_ROOM) {
                    velocity.x = -speed;
                }
                else if (x + BLIND_FOLLOW_WIGGLE_ROOM < target.x) {
                    velocity.x = speed;
                }
            }
            if (target.y !== undefined) {
                if (target.y < y - BLIND_FOLLOW_WIGGLE_ROOM) {
                    velocity.y = -speed;
                }
                else if (y + BLIND_FOLLOW_WIGGLE_ROOM < target.y) {
                    velocity.y = speed;
                }
            }
        }

        override public function update():void
        {
            pathTimer--;
            pathfind();
        }

    }
}


import org.noorhakim.FlxMovieClip;

/**
 * Pixels of sprite sheet are in this.bitmapData.
 * "EnemyClip" class is defined in the SWF and the SWC.
 */
class EnemySpriteSheet extends FlxMovieClip
{
    public function EnemySpriteSheet()
    {
        super(EnemyClip);
    }
}

