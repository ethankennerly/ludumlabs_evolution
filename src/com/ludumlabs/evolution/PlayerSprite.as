package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class PlayerSprite extends FlxSprite
    {
        public static var speed:int = 80;

        /**
         * Load sprite sheet and position at center of image.
         */
        public function PlayerSprite(X:int = 0, Y:int = 0, SimpleGraphic:Class = null)
        {
            super(X, Y);
            var sheet:PlayerSpriteSheet = new PlayerSpriteSheet();
            this.loadGraphic(PlayerSpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            this.offset.x = this.frameWidth * 0.5;
            this.offset.y = this.frameHeight * 0.5;
            this.centerOffsets();

            drag.x = speed * 8;
            maxVelocity.x = speed;
            maxVelocity.y = speed;
        }

        /**
         * Press arrow keys to move.
         */
        public function updateInput():void 
        {
            if (alive) {
                velocity.x = 0;
                velocity.y = 0;
                if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A")) {
                    velocity.x = -speed;
                }
                else if (FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D")) {
                    velocity.x = speed;
                }
                if (FlxG.keys.pressed("UP") || FlxG.keys.pressed("W")) {
                    velocity.y = -speed;
                }
                else if (FlxG.keys.pressed("DOWN") || FlxG.keys.pressed("S")) {
                    velocity.y = speed;
                }
            }
        }
    }
}


import org.noorhakim.FlxMovieClip;

/**
 * Pixels of sprite sheet are in this.bitmapData.
 * "PlayerClip" class is defined in the SWF and the SWC.
 */
class PlayerSpriteSheet extends FlxMovieClip
{
    public function PlayerSpriteSheet()
    {
        super(PlayerClip);
    }
}

