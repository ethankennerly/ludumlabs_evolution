package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        public var player:PlayerSprite;
        public var enemies:FlxGroup;
        public var mobiles:FlxGroup;
        
        public var level:Level_firstLevel;
        
        //public static function onLoadObject(obj:Object, layer:FlxGroup, level:BaseLevel, properties:Array):void {}

        override public function create():void
        {
            FlxG.levels = [Level_firstLevel];
            level = new Level_firstLevel();
            
            mobiles = new FlxGroup();
            
            player = new PlayerSprite(FlxG.width / 2, FlxG.height / 2);
            mobiles.add(player);
            
            enemies = new FlxGroup();
            var enemy:EnemySprite = new EnemySprite(FlxG.width / 4, FlxG.height / 4);
            enemies.add(enemy);
            mobiles.add(enemies);
            
            add(mobiles);
            
            add(new FlxText(0, 0, 200, "Press arrow keys to move"));
        }

        override public function update():void
        {
            FlxG.collide(level.mainLayer,mobiles); //putting this after updateInput makes a weird bobbing behavior while running into the wall
            player.updateInput();
            
            for each (var enemy:EnemySprite in enemies.members) {
                enemy.targetX = Math.round(player.x);
                enemy.targetY = Math.round(player.y);
            }
            FlxG.overlap(enemies, player, overlapEnemy);			
            super.update();
        }

        protected function overlapEnemy(enemyObject:FlxObject, playerObject:FlxObject):void
        {
            enemyObject.flicker(1);
            playerObject.kill();
        }
    }
}
