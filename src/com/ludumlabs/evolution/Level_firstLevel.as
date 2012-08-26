//Code generated with DAME. http://www.dambots.com

package com.ludumlabs.evolution
{
	import org.flixel.*;
	public class Level_firstLevel extends BaseLevel
	{
		//Embedded media...
		[Embed(source="mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Group1Map1:Class;
		[Embed(source="../../../../nethack-3.4.3-16x16.png")] public var Img_Group1Map1:Class;

		//Tilemaps
		public var layerGroup1Map1:FlxTilemap;

		//Sprites
		public var Group1Layer2Group:FlxGroup = new FlxGroup;


		public function Level_firstLevel(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Map1 = new FlxTilemap;
			layerGroup1Map1.loadMap( new CSV_Group1Map1, Img_Group1Map1, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1Map1.x = 0.000000;
			layerGroup1Map1.y = 0.000000;
			layerGroup1Map1.scrollFactor.x = 0.000000;
			layerGroup1Map1.scrollFactor.y = 0.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerGroup1Map1);
			masterLayer.add(Group1Layer2Group);


			if ( addToStage )
			{
				addSpritesForLayerGroup1Layer2(onAddSpritesCallback);
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerGroup1Map1;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 640;
			boundsMaxY = 480;

		}

		override public function addSpritesForLayerGroup1Layer2(onAddCallback:Function = null):void
		{
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 88.000, 115.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 174.000, 103.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 237.000, 86.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 277.000, 93.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 346.000, 88.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 364.000, 112.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 428.000, 98.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 461.000, 118.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 522.000, 112.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(PlayerSprite, Group1Layer2Group , 311.000, 323.000, 0.000, false, 1, 1, onAddCallback );//"Player"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 94.000, 159.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 163.000, 164.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 233.000, 154.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 285.000, 134.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 329.000, 167.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 414.000, 161.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 486.000, 200.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 543.000, 170.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 545.000, 262.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 437.000, 223.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 367.000, 203.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 280.000, 203.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 208.000, 207.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 138.000, 216.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 80.000, 230.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 121.000, 273.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 188.000, 255.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 160.000, 314.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 63.000, 298.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 100.000, 346.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 195.000, 55.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 100.000, 54.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 53.000, 97.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 306.000, 46.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 384.000, 52.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 461.000, 55.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 529.000, 64.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 583.000, 108.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 577.000, 199.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 502.000, 247.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 462.000, 274.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 531.000, 308.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 583.000, 335.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 542.000, 375.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 493.000, 347.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 38.000, 199.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 164.000, 379.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 58.000, 375.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 97.000, 417.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 463.000, 404.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 584.000, 425.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 462.000, 323.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 487.000, 162.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 490.000, 78.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 252.000, 40.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 142.000, 37.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 49.000, 155.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 115.000, 318.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 140.000, 350.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 143.000, 380.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 199.000, 424.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 32.000, 213.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 54.000, 254.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 310.000, 109.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 368.000, 151.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 402.000, 128.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 395.000, 78.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 409.000, 53.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 440.000, 48.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 445.000, 297.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 509.000, 294.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 509.000, 382.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 490.000, 443.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 580.000, 376.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 544.000, 319.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 573.000, 76.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 57.000, 35.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 67.000, 68.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 45.000, 370.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 62.000, 426.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 32.000, 303.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 32.000, 342.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
		}


	}
}
