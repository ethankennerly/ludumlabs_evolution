package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class MenuState extends FlxState
    {
        public static var fading:Boolean;

        override public function create():void
        {
            MenuState.fading = false;
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

            FlxG.bgColor = 0xFF999999;
        }

        override public function update():void
        {
            super.update();

            if(!MenuState.fading && FlxG.mouse.justPressed())
            {
                MenuState.fading = true;
                FlxG.score = 0;
                FlxG.save = 3;
                FlxG.level = 0;
                FlxG.play(Sounds.Pickup);
                FlxG.fade(0xFF999999, 2, MenuState.switchPlay);
            }
        }

        public static function switchPlay():void
        {
            MenuState.fading = false;
            FlxG.switchState(new PlayState());
        }

        public static function clickToReturn():void
        {
            if(!MenuState.fading && FlxG.mouse.justPressed()) {
                MenuState.fading = true;
                FlxG.play(Sounds.Pickup);
                FlxG.fade(0xFF999999, 2, MenuState.goto);
            }
        }

        public static function goto():void
        {
            MenuState.fading = false;
            FlxG.switchState(new MenuState());
        }
    }
}
