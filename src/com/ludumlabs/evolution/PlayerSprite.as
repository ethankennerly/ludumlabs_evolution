package com.ludumlabs.evolution
{
    import flash.events.KeyboardEvent;
    import org.flixel.*;

    public class PlayerSprite extends FlxSprite
    {
        public static var speed:int = 80;
        public static var bulletMax:int = 64;
        public var bullets:FlxGroup;
        public var move:Function;
        public var shoot:Function;
        public var spawn:Function;
        public var journal:Journal;

        /**
         * Load sprite sheet and position at center of image.
         * Record any call to "move" or "shoot" in journal.
         */
        public function PlayerSprite(X:int = 0, Y:int = 0, SimpleGraphic:Class = null)
        {
            super(X, Y);
            var sheet:PlayerSpriteSheet = new PlayerSpriteSheet();
            this.loadGraphic(PlayerSpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            this.offset.x = this.frameWidth * 0.5;
            this.offset.y = this.frameHeight * 0.5;
            this.centerOffsets();

            maxVelocity.x = speed;
            maxVelocity.y = speed;

            bullets = new FlxGroup();
            for (var b:int; b < bulletMax; b++) {
                bullets.add(new BulletSprite());
            }
            journal = new Journal();
            move = journal.decorate("move", this, _move);
            shoot = journal.decorate("shoot", this, _shoot);
            spawn = journal.decorate("spawn", this, _spawn);
            spawn(X, Y);
        }

        public function _spawn(spawnX:int, spawnY:int):void
        {
            reset(spawnX, spawnY);
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
                }
            }
        }

        public function mayMove():void 
        {
            if (FlxG.keys.justPressed("LEFT") || FlxG.keys.justPressed("A")) {
                move("x", -speed);
            }
            else if (FlxG.keys.justReleased("LEFT") || FlxG.keys.justReleased("A")) {
                move("x", 0);
            }
            if (FlxG.keys.justPressed("RIGHT") || FlxG.keys.justPressed("D")) {
                move("x", speed);
            }
            else if (FlxG.keys.justReleased("RIGHT") || FlxG.keys.justReleased("D")) {
                move("x", 0);
            }
            if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W")) {
                move("y", -speed);
            }
            else if (FlxG.keys.justReleased("UP") || FlxG.keys.justReleased("W")) {
                move("y", 0);
            }
            if (FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("S")) {
                move("y", speed);
            }
            else if (FlxG.keys.justReleased("DOWN") || FlxG.keys.justReleased("S")) {
                move("y", 0);
            }
        }

        public function _move(axis:String, velocity:Number):void
        {
            this.velocity[axis] = velocity;
        }

        public function mayShoot():void
        {
            if (FlxG.mouse.justPressed()) {
                shoot(FlxG.mouse.screenX, FlxG.mouse.screenY);
            }
        }

        public function _shoot(targetX:int, targetY:int):void
        {
            BulletSprite.shootGroup(this, bullets, targetX, targetY);
        }

        override public function kill():void
        {
            super.kill();
            if (!journal.replaying) {
                journal.replay(true);
                alive = true;
            }
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

