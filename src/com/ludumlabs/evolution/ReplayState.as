package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class ReplayState extends FlxState
    {
        public static var timeout:Number = 1.0;
        public var accumulated:Number;

        override public function create():void
        {
            accumulated = 0;
            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,
                "Evolving...\n" + FlxG.save 
                + (1 == FlxG.save ? " life" : " lives")
                + " left");
            t.size = 16;
            t.alignment = "center";
            add(t);
            
            trace("ReplayState");
        }

        override public function update():void
        {
            super.update();
            accumulated += FlxG.elapsed;
            if (timeout < accumulated) {
                FlxG.switchState(new PlayState());
            }
        }
    }
}
