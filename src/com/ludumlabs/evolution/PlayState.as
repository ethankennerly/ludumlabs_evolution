package com.ludumlabs.evolution
{
    import dja.utils.b2;
    import Box2D.Dynamics.b2World;
    import flash.display.Sprite;
    
    import org.flixel.*;
    
    public class PlayState extends FlxState
    {
        public static var lives:FlxText;
        public static var level:FlxText;
        public static var score:FlxText;
        public static var highScore:FlxText;
        public static var journals:Array;

        public var replayers:FlxGroup;
        public var playing:Boolean;

        public var player:PlayerSprite;
        public var enemies:FlxGroup;
        public var mobiles:FlxGroup;
        public var nonEnemyMobiles:FlxGroup;
        
        public var level:Level_firstLevel;
        
        public var world:b2World;
        
        //public static function onLoadObject(obj:Object, layer:FlxGroup, level:BaseLevel, properties:Array):void {}

        public static function addHud(state:FlxState):void
        {
            PlayState.lives = new FlxText(FlxG.width-220,20,200, "");
            PlayState.lives.alignment = "right";
            PlayState.score = new FlxText(FlxG.width-220,36,200, "");
            PlayState.score.alignment = "right";
            PlayState.highScore = new FlxText(FlxG.width-220,48,200, "");
            PlayState.highScore.alignment = "right";
            PlayState.level = new FlxText(FlxG.width-220,64,200, "");
            PlayState.level.alignment = "right";
            PlayState.updateHud();
            state.add(PlayState.lives);
            state.add(PlayState.score);
            state.add(PlayState.highScore);
            state.add(PlayState.level);
        }

        public static function updateHud():void
        {
            if (undefined === FlxG.save) {
                FlxG.save = 3;
            }
            PlayState.lives.text = "Lives " + FlxG.save.toString();
            if (undefined === FlxG.score) {
                FlxG.score = 0;
            }
            PlayState.score.text = "Score " + FlxG.score.toString();
            if (undefined === FlxG.scores || 0 == FlxG.scores.length) {
                FlxG.scores = [0];
            }
            PlayState.highScore.text = "High score " + Math.max.apply(null, FlxG.scores).toString();
            PlayState.level.text = "Level " + (FlxG.level + 1).toString() 
                + " of " + FlxG.levels.length.toString();
        }

        override public function create():void
        {
            super.create();
            PlayerSprite.state = this;
            if (null == PlayState.journals) {
                PlayState.journals = [];
            }
            restart();
            add(new FlxText(20, 20, 200, "Press arrow keys to move\nClick mouse to shoot"));
            PlayState.addHud(this);
        }
       
        public function restart():void
        {
            enemies = new FlxGroup();
            mobiles = new FlxGroup();
            nonEnemyMobiles = new FlxGroup();
            
            setLevel(FlxG.level);
            
            //world.DrawDebugData();
            
            mobiles.add(enemies);
            replayers = replay(player);
            
            EnemySprite.tilemap = level.mainLayer;
            PlayerSprite.tilemap = level.mainLayer;
            EnemySprite.player = player;
            EnemySprite.replayers = replayers;
            playing = true;
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
            if (levelNum < 0 ||
                levelNum >= FlxG.levels.length) {
                
                trace("PlayState, setLevel, no such level: " + levelNum);
                return;
            }
            FlxG.bgColor = 0xFFAAAAAA;
            var levelClass:Class = FlxG.levels[levelNum];
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
            PlayState.updateHud();
            super.update();
            world.Step(FlxG.elapsed, 5);
           
            maySwitchState();
        }

        protected function overlapEnemy(enemyObject:FlxObject, playerObject:FlxObject):void
        {
            enemyObject.flicker(1);
            playerObject.hurt(1);
            FlxG.play(Sounds.Explosion);
        }

        public function maySwitchState():void
        {
            if (playing) {
                if (0 == enemies.countLiving()) {
                    playing = false;
                    PlayState.journals = [];
                    if (FlxG.level < FlxG.levels.length - 1) {
                        FlxG.fade(0xFFCCFFCC, 2, switchPlay);
                    }
                    else {
                        FlxG.fade(0xFFCCCCFF, 2, switchWin);
                    }
                }
                else if (!player.alive) {
                    playing = false;
                    FlxG.save--;
                    if (0 < FlxG.save) {
                        FlxG.fade(0xFFFFFFCC, 2, switchReplay);
                    }
                    else {
                        FlxG.fade(0xFF333333, 4, switchGameOver);
                    }
                }
            }
        }
        
        public function switchReplay():void
        {
            PlayState.journals.push(player.journal);
            player = null;
            FlxG.switchState(new ReplayState());
        }

        public function switchGameOver():void
        {
            PlayState.journals = [];
            FlxG.scores.push(FlxG.score);
            FlxG.switchState(new GameOverState());
        }

        private function switchPlay():void
        {
            FlxG.score += 500 * FlxG.save;
            FlxG.level++;
            FlxG.save ++;
            FlxG.switchState(new PlayState());
        }

        private function switchWin():void
        {
            FlxG.score += 1000 * FlxG.save;
            FlxG.scores.push(FlxG.score);
            FlxG.switchState(new WinState());
        }

    }
}
