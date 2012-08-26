package com.ludumlabs.evolution
{
    import org.flixel.*;

    public class BulletSprite extends FlxSprite
    {
        public static var speed:int = 160;

        /**
         * Load sprite sheet and position at center of image.
         * Small hitbox.
         */
        public function BulletSprite(X:int = 0, Y:int = 0, SimpleGraphic:Class = null)
        {
            super(X, Y);
            var sheet:BulletSpriteSheet = new BulletSpriteSheet();
            this.loadGraphic(BulletSpriteSheet, true, true, sheet.frameWidth, sheet.frameHeight);
            this.offset.x = this.frameWidth * 0.5;
            this.offset.y = this.frameHeight * 0.5;
            this.width = this.frameWidth * 0.5;
            this.height = this.frameHeight * 0.5;
            this.centerOffsets();

            maxVelocity.x = speed;
            maxVelocity.y = speed;
            exists = false;
        }

        override public function update():void
        {
            if (touching || !onScreen()) {
                kill();
            }
            super.update();
        }

        /**
         * Return true if did shoot.
         */
        public static function shootGroup(shooter:FlxSprite, bullets:FlxGroup, targetX:int, targetY:int):Boolean
        {
            var didShoot:Boolean = false;
            for each(var bullet:BulletSprite in bullets.members){
                if (! bullet.exists) {
                    didShoot = bullet.shoot(shooter, targetX, targetY);
                    break;
                }
            }
            return didShoot;
        }

        /**
         * Return true if did shoot.
         */
        public function shoot(shooter:FlxSprite, targetX:int, targetY:int):Boolean
        {
            var didShoot:Boolean = false;
            var dx:Number = targetX - shooter.x;
            var dy:Number = targetY - shooter.y;
            var dx2:Number = dx * dx;
            var dy2:Number = dy * dy;
            if (1 <= dx2 || 1 <= dy2) {
                reset(shooter.x + shooter.frameWidth * 0.5, shooter.y + shooter.frameHeight * 0.5);
                var scale:Number = speed / Math.sqrt(dx2 + dy2);
                velocity.x = dx * scale;
                velocity.y = dy * scale;
                solid = true;
                didShoot = true;
            }
            else {
                var message:String;
                message = "too close ";
                message += targetX + "," + targetY + " - " + shooter.x + "," + shooter.y;
                trace(message);
            }
            return didShoot;
        }

		public static function hitEnemy(bullet:FlxObject, enemy:FlxObject):void
		{
            FlxG.play(Sounds.Hit);
			bullet.kill();
			enemy.hurt(1);
            bullet.exists = false;
            FlxG.score += 100;
		}
    }
}


import org.noorhakim.FlxMovieClip;

/**
 * Pixels of sprite sheet are in this.bitmapData.
 * "BulletClip" class is defined in the SWF and the SWC.
 */
class BulletSpriteSheet extends FlxMovieClip
{
    public function BulletSpriteSheet()
    {
        super(BulletClip);
    }
}

