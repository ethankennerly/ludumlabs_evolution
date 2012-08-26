package com.ludumlabs.evolution 
{
	/**
     * ...
     * @author Ethan Kennerly
     */
    public class TankZombie extends EnemySprite 
    {
        
        public function TankZombie(X:int=0, Y:int=0, SimpleGraphic:Class=null) 
        {
            super(X, Y, SimpleGraphic);
			speed *= 0.75;
            pathfindingDelay *= 1.5;
            health *= 4;
        }
        
    }

}