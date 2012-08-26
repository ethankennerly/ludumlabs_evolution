package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class EnemySprite extends FlxSprite
    {
        public static var speed:int = 40;
        public static var target:PlayerSprite;
        public static var tilemap:FlxTilemap;
        
        private const PATHFINDING_DELAY:Number = 200;
        private const PATHFINDING_VARIANCE:Number = 0.9;
        private const PF_FOLLOW = 0;
        private const PF_GUESS = 1;
        
        public var pfState:Number;
        public var pathTimer:Number;

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
        }
        
        public function resetTimer():void
        {
            pathTimer = Math.floor( Math.random()*(PATHFINDING_DELAY*PATHFINDING_VARIANCE) + (PATHFINDING_DELAY*(1-PATHFINDING_VARIANCE)) );
        }

        public function wander():void
        {
            acceleration.x = (Math.random() - 0.5) * speed;
            acceleration.y = (Math.random() - 0.5) * speed;
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

