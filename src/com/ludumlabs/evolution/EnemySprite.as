package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class EnemySprite extends FlxSprite
    {
        public static var speed:int = 40;
        public static var target:PlayerSprite;

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
        }

        public function wander():void
        {
            acceleration.x = (Math.random() - 0.5) * speed;
            acceleration.y = (Math.random() - 0.5) * speed;
        }

        public function follow():void
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

