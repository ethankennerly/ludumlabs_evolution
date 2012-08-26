package com.ludumlabs.evolution 
{
	/**
     * ...
     * @author Ethan Kennerly
     */
    public class LurkerZombie extends EnemySprite 
    {
        
        public function LurkerZombie(X:int=0, Y:int=0, SimpleGraphic:Class=null) 
        {
            super(X, Y, SimpleGraphic);
			speed *= 2;
            tryPathfinding = false;
            health = 3;
        }
        
    }

}