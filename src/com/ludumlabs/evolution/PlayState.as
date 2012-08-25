package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        public var player:PlayerSprite;
        public var enemies:FlxGroup;
        public var mobiles:FlxGroup;
        
        public var level:BaseLevel;
		public var level_first:Level_firstLevel;
        
        public static function onLoadObject(obj:Object, layer:FlxGroup, level:BaseLevel, properties:Array):void {}

        override public function create():void
        {
            FlxG.levels = [Level_firstLevel];
            level = new Level_firstLevel();
            
            mobiles = new FlxGroup();
            
            player = new PlayerSprite(FlxG.width / 2, FlxG.height / 2);
            add(player);
            mobiles.add(player);
            
            enemies = new FlxGroup();
            var enemy:EnemySprite = new EnemySprite(FlxG.width / 4, FlxG.height / 4);
            enemies.add(enemy);
            mobiles.add(enemy);
            
            add(enemies);
            
            add(new FlxText(0, 0, 200, "Press arrow keys to move"));
        }

        override public function update():void
        {
            player.updateInput();
            
            //TODO:
            //level.hitTilemaps.collide(mobiles);
            
            for each (var enemy:EnemySprite in enemies.members) {
                enemy.targetX = player.x;
                enemy.targetY = player.y;
            }
            super.update();
        }
    }
}
