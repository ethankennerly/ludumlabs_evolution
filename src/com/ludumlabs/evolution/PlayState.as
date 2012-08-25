package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        public var player:PlayerSprite;
        public var enemies:FlxGroup;

        override public function create():void
        {
            player = new PlayerSprite(FlxG.width / 2, FlxG.height / 2);
            add(player);
            enemies = new FlxGroup();
            var enemy:EnemySprite = new EnemySprite(FlxG.width / 4, FlxG.height / 4);
            enemies.add(enemy);
            add(enemies);
            add(new FlxText(0, 0, 200, "Press arrow keys to move"));
        }

        override public function update():void
        {
            player.updateInput();
            for each (var enemy:EnemySprite in enemies.members) {
                enemy.targetX = player.x;
                enemy.targetY = player.y;
            }
            super.update();
        }
    }
}
