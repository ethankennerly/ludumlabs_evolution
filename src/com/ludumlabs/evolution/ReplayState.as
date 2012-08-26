package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class ReplayState extends FlxState
    {
        override public function create():void
        {
            FlxG.bgColor = 0xFFFFFFCC;
            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,
                "Evolving...\n" + FlxG.save 
                + (1 == FlxG.save ? " life" : " lives")
                + " left");
            t.color = 0x33333333;
            t.size = 16;
            t.alignment = "center";
            add(t);
            
            trace("ReplayState");
            FlxG.fade(0xFF999999, 2, MenuState.switchPlay);
        }

    }
}
