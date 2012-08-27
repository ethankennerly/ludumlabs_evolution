package com.ludumlabs.evolution 
{
    public class LurkerZombie extends EnemySprite 
    {
        
        public function LurkerZombie(X:int=0, Y:int=0, SimpleGraphic:Class=null) 
        {
            super(X, Y, SimpleGraphic);
            var sheet:LurkerSpriteSheet = new LurkerSpriteSheet();
            loadGraphic(LurkerSpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            offset.x = frameWidth * 0.5;
            offset.y = frameHeight * 0.5;
            centerOffsets();
			speed *= 2;
            tryPathfinding = false;
            health = 3;
        }
        
    }

}

import org.noorhakim.FlxMovieClip;

/**
 * Pixels of sprite sheet are in this.bitmapData.
 * "LurkerClip" class is defined in the SWF and the SWC.
 */
class LurkerSpriteSheet extends FlxMovieClip
{
    public function LurkerSpriteSheet()
    {
        super(LurkerClip);
    }
}
