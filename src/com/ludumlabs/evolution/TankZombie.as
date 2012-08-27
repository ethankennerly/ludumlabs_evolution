package com.ludumlabs.evolution 
{
    public class TankZombie extends EnemySprite 
    {
        
        public function TankZombie(X:int=0, Y:int=0, SimpleGraphic:Class=null) 
        {
            super(X, Y, SimpleGraphic);
            var sheet:TankSpriteSheet = new TankSpriteSheet();
            loadGraphic(TankSpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            offset.x = frameWidth * 0.5;
            offset.y = frameHeight * 0.5;
            centerOffsets();
			speed *= 0.75;
            pathfindingDelay *= 1.5;
            health *= 4;
        }
        
    }

}
import org.noorhakim.FlxMovieClip;

/**
 * Pixels of sprite sheet are in this.bitmapData.
 * "TankClip" class is defined in the SWF and the SWC.
 */
class TankSpriteSheet extends FlxMovieClip
{
    public function TankSpriteSheet()
    {
        super(TankClip);
    }
}
