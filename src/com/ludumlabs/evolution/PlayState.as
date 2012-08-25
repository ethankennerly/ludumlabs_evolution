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
            add(player);
            add(player.bullets);
            mobiles.add(player);
            mobiles.add(player.bullets);
            
            enemies = new FlxGroup();
            var enemy:EnemySprite = new EnemySprite(FlxG.width / 4, FlxG.height / 4);
            enemies.add(enemy);
            mobiles.add(enemy);
            
            add(enemies);
            
            add(new FlxText(16, 16, 200, "Press arrow keys to move\nClick mouse to shoot"));
        }

        override public function update():void
        {
            player.updateInput();
            
            FlxG.collide(level.mainLayer,mobiles);
            FlxG.overlap(player.bullets, enemies, BulletSprite.hitEnemy);
            
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
            playerObject.hurt(1);
        }
    }
}
