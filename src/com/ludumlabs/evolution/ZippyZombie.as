package com.ludumlabs.evolution 
{
	/**
     * ...
     * @author Ethan Kennerly
     */
    public class ZippyZombie extends EnemySprite 
    {
        //public static const speed = 150;
        
        
        public function ZippyZombie(X:int = 0, Y:int = 0, SimpleGraphic:Class = null)
        {
            super(X, Y, SimpleGraphic);
            speed *= 2;
            health = 2;
            pathfindingDelay /= 4;
            bodyMass *= 0.7;
            maxImpulse *= 0.7;
        }
    }

}