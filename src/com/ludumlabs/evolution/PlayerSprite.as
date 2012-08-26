package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class PlayerSprite extends FlxSprite
    {
        public static var speed:int = 80;
        public static var bulletMax:int = 64;
        public var shootInterval:Number = 0.25;
        public var mouseAccumulated:Number = 0.125;
        public var bullets:FlxGroup;
        public var move:Function;
        public var shoot:Function;
        public var spawn:Function;
        public var journal:Journal;
        public var lastXVelocity:Number;
        public var lastYVelocity:Number;
        public static var state:PlayState;

        /**
         * Load sprite sheet and position at center of image.
         * Record any call to "move" or "shoot" in journal.
         */
        public function PlayerSprite(X:int = 0, Y:int = 0, SimpleGraphic:Class = null)
        {
            super(X, Y);
            var sheet:PlayerSpriteSheet = new PlayerSpriteSheet();
            this.loadGraphic(PlayerSpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            maxVelocity.x = speed;
            maxVelocity.y = speed;
            addAnimation("idle", [0], 4);
            addAnimation("dead", [1], 4);
            play("dead");
        }

        public function createJournal(X:int, Y:int):Journal
        {
            var journal:Journal = new Journal();
            move = journal.decorate("move", this, "_move");
            shoot = journal.decorate("shoot", this, "_shoot");
            spawn = journal.decorate("spawn", this, "_spawn");
            play("idle");
            spawn(X, Y);
            return journal;
        }

        public function _spawn(spawnX:int, spawnY:int):void
        {
            reset(spawnX, spawnY);
            this.offset.x = this.frameWidth * 0.5;
            this.offset.y = this.frameHeight * 0.5;
            this.centerOffsets();
            
            this.lastXVelocity = this.lastYVelocity = 0;

            bullets = new FlxGroup();
            for (var b:int = 0; b < bulletMax; b++) {
                bullets.add(new BulletSprite());
            }
            mouseAccumulated = 0;
            state.nonEnemyMobiles.add(this);
            state.nonEnemyMobiles.add(bullets);
            state.add(this);
            state.add(bullets);
        }

        /**
         * Press arrow keys to move.
         * Click mouse to shoot.
         */
        public function updateInput():void 
        {
            if (alive) {
                if (journal.replaying) {
                    journal.update();
                }
                else {
                    mayMove();
                    mayShoot();
                    redoMove();
                }
            }
        }

        public function mayMove():void 
        {
            var tempVelocityX:int = 0;
            var tempVelocityY:int = 0;
            if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A")) {
                tempVelocityX -= speed;
            }
            if (FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D")) {
                tempVelocityX += speed;
            }
            if (FlxG.keys.pressed("UP") || FlxG.keys.pressed("W")) {
                tempVelocityY -= speed;
            }
            if (FlxG.keys.pressed("DOWN") || FlxG.keys.pressed("S")) {
                tempVelocityY += speed;
            }
            if (tempVelocityX != lastXVelocity) {
                move("x", tempVelocityX);
            }
            if (tempVelocityY != lastYVelocity) {
                move("y", tempVelocityY);
            }
        }

        public function _move(axis:String, vel:Number):void
        {
            this.velocity[axis] = vel;
            
            if (axis == "x") lastXVelocity = vel;
            if (axis == "y") lastYVelocity = vel;
        }
        
        // This is to address the bug of a directional key being ignored if you're running into/along a wall
        // and eventually get past the wall but keep going parallel to the wall rather than past it diagonally (ask John)
        public function redoMove():void
        {
            if(lastXVelocity != 0) this.velocity["x"] = lastXVelocity;
            if(lastYVelocity != 0) this.velocity["y"] = lastYVelocity;
        }

        public function mayShoot():void
        {
            var repeatShoot:Boolean = updateRepeat();
            if (FlxG.mouse.justPressed() || repeatShoot) {
                shoot(FlxG.mouse.screenX, FlxG.mouse.screenY);
            }
        }

        public function _shoot(targetX:int, targetY:int):void
        {
            if (BulletSprite.shootGroup(this, bullets, targetX, targetY)) {
                FlxG.play(Sounds.Shoot);
            }
        }

        public function updateRepeat():Boolean
        {
            var repeatNow:Boolean = false;
            if (FlxG.mouse.pressed()) {
                mouseAccumulated += FlxG.elapsed;
            }
            else {
                mouseAccumulated = 0;
            }
            if (shootInterval < mouseAccumulated) {
                mouseAccumulated -= shootInterval;
                repeatNow = true;
            }
            return repeatNow;
        }
    }
}


import org.noorhakim.FlxMovieClip;

/**
 * Pixels of sprite sheet are in this.bitmapData.
 * "PlayerClip" class is defined in the SWF and the SWC.
 */
class PlayerSpriteSheet extends FlxMovieClip
{
    public function PlayerSpriteSheet()
    {
        super(PlayerClip);
    }
}

