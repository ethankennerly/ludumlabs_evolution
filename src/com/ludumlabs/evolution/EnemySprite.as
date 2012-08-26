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
        public static var speed:int = 40;
        public static var target:PlayerSprite;
        public static var tilemap:FlxTilemap;
        
        private const PATHFINDING_DELAY:Number = 100;
        private const PATHFINDING_VARIANCE:Number = 0.9;
        private const PF_FOLLOW = 0;
        private const PF_GUESS = 1;
        
        public var pfState:Number;
        public var pathTimer:Number;
        
        public var body:b2Body;
        public var bodyMass:Number;
        public var maxImpulse:Number;
        
        public var tempVec:b2Vec2;

        /**
         * Load sprite sheet and position at center of image.
         */
        public function EnemySprite(X:int = 0, Y:int = 0, SimpleGraphic:Class = null)
        {
            super(X, Y);
            var sheet:EnemySpriteSheet = new EnemySpriteSheet();
            loadGraphic(EnemySpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            offset.x = frameWidth * 0.5;
            offset.y = frameHeight * 0.5;
            centerOffsets();

            drag.x = speed * 8;
            maxVelocity.x = speed;
            maxVelocity.y = speed;
            
            pathTimer = 0;
            pfState = PF_GUESS;
            
            bodyMass = 1;
            maxImpulse = 1;
            
            tempVec = new b2Vec2();
        }
        
        override public function kill():void
        {
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
            pathTimer = Math.floor( Math.random()*(PATHFINDING_DELAY*PATHFINDING_VARIANCE) + (PATHFINDING_DELAY*(1-PATHFINDING_VARIANCE)) );
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
            
            ///
            
			x = b2.x(body) - 0.5*width;
			y = b2.y(body) - 0.5*height;
		}

        public function follow():void
        {
            
            
            //TODO: this still doesn't work
            pathfind();
        }
        
        public function pathfind():void
        {
            var path:FlxPath
            
            if (pathTimer <= 0) {
                resetTimer();
                path = tilemap.findPath(new FlxPoint(x + width / 2, y + height / 2), new FlxPoint(target.x + target.width / 2, target.y + target.height / 2));
                if(path) {
                    pfState = PF_FOLLOW;
                    followPath(path);
                } else {
                    stopFollowingPath();
                    pfState = PF_GUESS;
                }
            }
            
            if (pfState == PF_GUESS) {
                blindFollow();
            }
        }
        
        public function blindFollow():void
        {
            velocity.x = 0;
            velocity.y = 0;
            if (target.x !== undefined) {
                if (target.x < x - 1) {
                    velocity.x = -speed;
                }
                else if (x + 1 < target.x) {
                    velocity.x = speed;
                }
            }
            if (target.y !== undefined) {
                if (target.y < y - 1) {
                    velocity.y = -speed;
                }
                else if (y + 1 < target.y) {
                    velocity.y = speed;
                }
            }
        }

        override public function update():void
        {
            pathTimer--;
            follow();
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

