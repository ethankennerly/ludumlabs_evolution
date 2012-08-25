package com.ludumlabs.evolution
{
    import org.flixel.*;
    import flash.utils.getQualifiedClassName;

    public class PlayState extends FlxState
    {
        public var player:PlayerSprite;
        public var enemies:FlxGroup;
        public var mobiles:FlxGroup;
        
        public var level:Level_firstLevel;
        
        //public static function onLoadObject(obj:Object, layer:FlxGroup, level:BaseLevel, properties:Array):void {}

        override public function create():void
        {
            
            enemies = new FlxGroup();
            mobiles = new FlxGroup();
            
            FlxG.levels = [Level_firstLevel];
            level = new Level_firstLevel(true, onAddSpriteCallback);
            
            mobiles.add(player);
            mobiles.add(enemies);
            
            add(new FlxText(0, 0, 200, "Press arrow keys to move"));
        }
        
        protected function onAddSpriteCallback(newSprite:FlxSprite, layerGroup:FlxGroup):void
            if(newSprite is EnemySprite) enemies.add(EnemySprite(newSprite));
            if(newSprite is PlayerSprite) player = PlayerSprite(newSprite);
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
