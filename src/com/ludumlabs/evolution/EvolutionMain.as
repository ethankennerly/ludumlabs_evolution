package com.ludumlabs.evolution
{
    import flash.display.Sprite;
    import flash.events.Event;
    import org.flixel.*;
    
    [SWF(width="800", height="600", backgroundColor="#AAAAAA")]
    [Frame(factoryClass="Preloader")]

    import org.flixel.FlxGame;
    
    public class EvolutionMain extends FlxGame
    {
        public function EvolutionMain()
        {
            super(800, 600, MenuState, 1);
        }
    }
}
