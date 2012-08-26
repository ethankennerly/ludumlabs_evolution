package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class GameOverState extends FlxState
    {
        public var accumulated:Number;

        override public function create():void
        {
            accumulated = 0;
            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,"Game Over\n\nClick anywhere");
            t.size = 16;
            t.alignment = "center";
            add(t);
            PlayState.addHud(this);
            
            trace("GameOverState");
        }

        override public function update():void
        {
            super.update();
            if(FlxG.mouse.justPressed())
            {
                FlxG.switchState(new MenuState());
            }
        }
    }
}
