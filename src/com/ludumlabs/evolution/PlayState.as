package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        public var player:PlayerSprite;

        override public function create():void
        {
            player = new PlayerSprite(FlxG.width / 2, FlxG.height / 2);
            add(player);
            add(new FlxText(0,0,100,"INSERT GAME HERE"));
        }

        override public function update():void
        {
            player.updateInput();
            super.update();
        }
    }
}
