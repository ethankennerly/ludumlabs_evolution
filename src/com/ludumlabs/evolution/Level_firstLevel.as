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
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 195.000, 55.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 100.000, 54.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 306.000, 46.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 384.000, 52.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 461.000, 55.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 529.000, 64.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 252.000, 40.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 142.000, 37.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 409.000, 53.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 440.000, 48.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 573.000, 76.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 57.000, 35.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 67.000, 68.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 559.000, 37.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 496.000, 36.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 346.000, 34.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 193.000, 27.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 96.000, 27.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 21.000, 47.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 432.000, 25.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 278.000, 23.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 221.000, 45.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 527.000, 33.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 165.000, 21.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 596.000, 30.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(PlayerSprite, Group1Layer2Group , 336.000, 327.000, 0.000, false, 1, 1, onAddCallback );//"Player"
		}


	}
}
