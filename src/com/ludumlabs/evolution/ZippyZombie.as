package com.ludumlabs.evolution 
{
    public class ZippyZombie extends EnemySprite 
    {
        //public static const speed = 150;
        
        
        public function ZippyZombie(X:int = 0, Y:int = 0, SimpleGraphic:Class = null)
        {
            super(X, Y, SimpleGraphic);
            var sheet:ZippySpriteSheet = new ZippySpriteSheet();
            loadGraphic(ZippySpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            offset.x = frameWidth * 0.5;
            offset.y = frameHeight * 0.5;
            centerOffsets();
            speed *= 2;
            health = 2;
            pathfindingDelay /= 4;
            bodyMass *= 0.7;
            maxImpulse *= 0.7;
        }
    }

}
import org.noorhakim.FlxMovieClip;

/**
 * Pixels of sprite sheet are in this.bitmapData.
 * "ZippyClip" class is defined in the SWF and the SWC.
 */
class ZippySpriteSheet extends FlxMovieClip
{
    public function ZippySpriteSheet()
    {
        super(ZippyClip);
    }
}
