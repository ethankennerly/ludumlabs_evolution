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

            FlxG.bgColor = 0xFF999999;
        }

        override public function update():void
        {
            super.update();

            if(FlxG.mouse.justPressed())
            {
                FlxG.score = 0;
                FlxG.save = 3;
                FlxG.level = 0;
                FlxG.play(Sounds.Pickup);
                FlxG.fade(0xFF999999, 2, MenuState.switchPlay);
            }
        }

        public static function switchPlay():void
        {
            FlxG.switchState(new PlayState());
        }

        public static function clickToReturn():void
        {
            if(FlxG.mouse.justPressed()) {
                FlxG.play(Sounds.Pickup);
                FlxG.fade(0xFF999999, 2, MenuState.goto);
            }
        }

        public static function goto():void
        {
            FlxG.switchState(new MenuState());
        }
    }
}
