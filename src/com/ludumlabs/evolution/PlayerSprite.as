package com.ludumlabs.evolution
{
    import dja.utils.b2;
    import Box2D.Dynamics.b2World;
    import Box2D.Dynamics.b2Body;
    
    import org.flixel.*;

    public class PlayerSprite extends FlxSprite
    {
        public static var speed:int = 80;
        public static var bulletMax:int = 64;
        public var bullets:FlxGroup;
        
        public var body:b2Body;

        /**
         * Load sprite sheet and position at center of image.
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
        }
        
        public function initPhysics(world:b2World):void
        {
            body = b2.body(world, { x:x + 0.5*width, y:y + 0.5*height });
            b2.circle(body, { radius:0.5*width });
        }

        /**
         * Press arrow keys to move.
         * Click mouse to shoot.
         */
        public function updateInput():void 
        {
            if (alive) {
                mayMove();
                mayShoot();
            }
        }

        public function mayMove():void 
        {
            velocity.x = 0;
            velocity.y = 0;
            if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A")) {
                velocity.x = -speed;
            }
            else if (FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D")) {
                velocity.x = speed;
            }
            if (FlxG.keys.pressed("UP") || FlxG.keys.pressed("W")) {
                velocity.y = -speed;
            }
            else if (FlxG.keys.pressed("DOWN") || FlxG.keys.pressed("S")) {
                velocity.y = speed;
            }
        }

        public function mayShoot():void
        {
            if (FlxG.mouse.justPressed()) {
                BulletSprite.shootGroup(this, bullets, FlxG.mouse.screenX, FlxG.mouse.screenY);
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

