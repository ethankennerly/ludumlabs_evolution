package com.ludumlabs.evolution 
{
    public class LurkerZombie extends EnemySprite 
    {
        
        public function LurkerZombie(X:int=0, Y:int=0, SimpleGraphic:Class=null) 
        {
            super(X, Y, SimpleGraphic);
			speed *= 2;
            tryPathfinding = false;
            health = 3;
            color = 0x33000000;
        }
        
    }

}
