package com.ludumlabs.evolution
{
    import dja.utils.b2;
    import Box2D.Dynamics.b2World;
    import flash.display.Sprite;
    
    import org.flixel.*;
    
    public class PlayState extends FlxState
    {
        public static var journals:Array;
        public var replayers:FlxGroup;

        public var player:PlayerSprite;
        public var enemies:FlxGroup;
        public var mobiles:FlxGroup;
        public var nonEnemyMobiles:FlxGroup;
        
        public var level:Level_firstLevel;
        
        public var world:b2World;
        
        //public static function onLoadObject(obj:Object, layer:FlxGroup, level:BaseLevel, properties:Array):void {}

        override public function create():void
        {
            super.create();
            PlayerSprite.state = this;
            FlxG.levels = [Level_firstLevel];
            if (null == PlayState.journals) {
                PlayState.journals = [];
            }
            restart();
            add(new FlxText(16, 16, 200, "Press arrow keys to move\nClick mouse to shoot"));
        }
       
        public function restart():void
        {
            enemies = new FlxGroup();
            mobiles = new FlxGroup();
            nonEnemyMobiles = new FlxGroup();
            
            setLevel(1);
            
            //world.DrawDebugData();
            
            EnemySprite.target = player;
            EnemySprite.tilemap = level.mainLayer;
            mobiles.add(enemies);
            replayers = replay(player);
        }

        /** 
         * Recreate players that were destroyed and assign them journals.
         */
        public function replay(player:PlayerSprite):FlxGroup
        {
            player.journal = player.createJournal(player.x, player.y);
            var replayers:FlxGroup = new FlxGroup();
            for each(var journal:Journal in journals) {
                var replayer:PlayerSprite = new PlayerSprite();
                replayer.journal = journal;
                replayer.journal.replay(true, replayer);
                replayers.add(replayer);
            }
            return replayers;
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
            
            createWorld();
        }
        
        protected function createWorld():void
        {
            var tilemap:FlxTilemap = level.layerGroup1Map1;
            
            var debugDrawSprite:Sprite = new Sprite(), container:Sprite = FlxG.camera.getContainerSprite();
            debugDrawSprite.x = -0.5*tilemap.width;
            debugDrawSprite.y = -0.5*tilemap.height;
            container.addChild(debugDrawSprite);
            
            world = b2.world( { gravityY:0, doSleep:false } ); //, debugDrawSprite:debugDrawSprite });
            
            for (var i:int = 0; i < tilemap.widthInTiles; i++) {
                
                for (var j:int = 0; j < tilemap.heightInTiles; j++) {
                    
                    if (tilemap.getTile(i, j) > 0) {
                        
                        b2.box(world.m_groundBody, { x:(i + 0.5)*tilemap._tileWidth, y:(j + 0.5)*tilemap._tileHeight, width:tilemap._tileWidth, height:tilemap._tileHeight, friction:0, computeBodyMass:false });
                    }
                }
            }
            if (enemies != null) {
                
                var enemyArr:Array = enemies.members, enemyCount:int = enemyArr.length;
                
                for (var k:int = 0; k < enemyCount; k++) {
                    
                    var enemy:EnemySprite = enemyArr[k] as EnemySprite;
                    
                    if (enemy != null) {
                        
                        enemy.initPhysics(world);
                    }
                }
            }
            //if (player != null) {
                
            //    player.initPhysics(world);
            //}
        }
        
        protected function onAddSpriteCallback(newSprite:FlxSprite, layerGroup:FlxGroup):void
        {
            if (newSprite is EnemySprite) {
                
                enemies.add(newSprite);
            }
            if (newSprite is PlayerSprite) {
                
                player = newSprite as PlayerSprite;
            }
        }

        override public function update():void
        {
            FlxG.collide(level.mainLayer,nonEnemyMobiles); //putting this after updateInput makes a weird bobbing behavior while running into the wall
            player.updateInput();
            FlxG.overlap(player.bullets, enemies, BulletSprite.hitEnemy);
            for each(var replayer:PlayerSprite in replayers.members) {
                replayer.updateInput();
                FlxG.overlap(replayer.bullets, enemies, BulletSprite.hitEnemy);
            }
            FlxG.overlap(enemies, player, overlapEnemy);            
            FlxG.overlap(enemies, replayers, overlapEnemy);            
            super.update();
            world.Step(FlxG.elapsed, 5);
            
            if (!player.alive) {
                PlayState.journals.push(player.journal);
                player = null;
                FlxG.switchState(new ReplayState());
                return;
            }
        }
        
        protected function overlapEnemy(enemyObject:FlxObject, playerObject:FlxObject):void
        {
            enemyObject.flicker(1);
            playerObject.hurt(1);
        }
    }
}
