package com.ludumlabs.evolution
{
    import flash.display.Sprite;
    import flash.events.Event;
    import org.flixel.*;
    
    [SWF(width="640", height="480", backgroundColor="#AAAAAA")]
    [Frame(factoryClass="Preloader")]

    import org.flixel.FlxGame;
    
    public class EvolutionMain extends FlxGame
    {
        public function EvolutionMain()
        {
            super(640, 480, MenuState, 1);
        }
    }
}
