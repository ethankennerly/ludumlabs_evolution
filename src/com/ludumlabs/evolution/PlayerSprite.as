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
         * Move by arrow keys.
         */
        public function updateInput():void 
        {
            if (alive) {
                velocity.x = 0;
                velocity.y = 0;
                if (FlxG.keys.pressed("LEFT")) {
                    velocity.x = -speed;
                }
                else if (FlxG.keys.pressed("RIGHT")) {
                    velocity.x = speed;
                }
                if (FlxG.keys.pressed("UP")) {
                    velocity.y = -speed;
                }
                else if (FlxG.keys.pressed("DOWN")) {
                    velocity.y = speed;
                }
            }
        }
    }
}


import org.noorhakim.FlxMovieClip;

/**
 * Pixels of sprite sheet are in this.bitmapData.
 */
class PlayerSpriteSheet extends FlxMovieClip
{
    /**
     * AS3 embedded gotcha: Need to 2 frames to declare movieclip.
     * http://www.airtightinteractive.com/2008/05/as3-embedded-movieclip-gotcha/
     */
    // [Embed(source="../../../../bin/EvolutionAssets.swf", symbol="Player")]
    public static var MovieClipClass:Class;

    public function PlayerSpriteSheet()
    {
        super(PlayerClip);
    }
}

