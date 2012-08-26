package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class MenuState extends FlxState
    {
        override public function create():void
        {
            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,"Evolution");
            t.size = 16;
            t.alignment = "center";
            add(t);
            t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"Click to play");
            t.alignment = "center";
            add(t);
           
            FlxG.levels = [Level_firstLevel];
            PlayState.addHud(this);

            FlxG.mouse.show();
            trace("MenuState");
        }

        override public function update():void
        {
            super.update();

            if(FlxG.mouse.justPressed())
            {
                FlxG.score = 0;
                FlxG.save = 3;
                FlxG.level = 0;
                FlxG.switchState(new PlayState());
            }
        }
    }
}
