package com.ludumlabs.evolution
{
    import dja.utils.b2;
    import Box2D.Dynamics.b2World;
    
    import org.flixel.*;
    import flash.display.Sprite;
    
    public class PlayState extends FlxState
    {
        public var player:PlayerSprite;
        public var enemies:FlxGroup;
        public var mobiles:FlxGroup;
        
        public var level:Level_firstLevel;
        
        public var world:b2World;
        
        //public static function onLoadObject(obj:Object, layer:FlxGroup, level:BaseLevel, properties:Array):void {}

        override public function create():void
        {
            
            enemies = new FlxGroup();
            mobiles = new FlxGroup();
            
            FlxG.levels = [Level_firstLevel];
            setLevel(1);
            
            world.DrawDebugData();
            
            EnemySprite.target = player;
            EnemySprite.tilemap = level.mainLayer;
            
            add(player.bullets);
            mobiles.add(player.bullets);
            mobiles.add(player);
            mobiles.add(enemies);
            
            add(new FlxText(16, 16, 200, "Press arrow keys to move\nClick mouse to shoot"));
        }
        
        protected function setLevel(levelNum:int):void
        {
            if (levelNum < 1 ||
                levelNum > FlxG.levels.length) {
                
                trace("PlayState, setLevel, no such level: " + levelNum);
                return;
            }
            var levelClass:Class = FlxG.levels[levelNum - 1];
            level = new levelClass(true, onAddSpriteCallback);
            
            initPhysics();
        }
        
        protected function initPhysics():void
        {
            var debugDrawSprite:Sprite = new Sprite(), container:Sprite = FlxG.camera.getContainerSprite();
            container.addChild(debugDrawSprite);
            
            world = b2.world({ gravityY:0, doSleep:false, debugDrawSprite:debugDrawSprite });
            var tilemap:FlxTilemap = level.layerGroup1Map1;
            
            for (var i:int = 0; i < tilemap.widthInTiles; i++) {
                
                for (var j:int = 0; j < tilemap.heightInTiles; j++) {
                    
                    if (tilemap.getTile(i, j) > 0) {
                        
                        b2.box(world.m_groundBody, { x:(i + 0.5)*tilemap._tileWidth - 0.5*tilemap.width, y:(j + 0.5)*tilemap._tileHeight - 0.5*tilemap.height, width:tilemap._tileWidth, height:tilemap._tileHeight, computeBodyMass:false });
                    }
                }
            }
        }
        
        protected function onAddSpriteCallback(newSprite:FlxSprite, layerGroup:FlxGroup):void
        {
            if(newSprite is EnemySprite) enemies.add(EnemySprite(newSprite));
            if(newSprite is PlayerSprite) player = PlayerSprite(newSprite);
        }

        override public function update():void
        {
            FlxG.collide(level.mainLayer,mobiles); //putting this after updateInput makes a weird bobbing behavior while running into the wall
            player.updateInput();
            
            FlxG.overlap(player.bullets, enemies, BulletSprite.hitEnemy);

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
