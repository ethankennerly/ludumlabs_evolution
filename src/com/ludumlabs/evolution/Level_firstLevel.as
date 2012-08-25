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
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 114.000, 112.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 174.000, 103.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 237.000, 86.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 277.000, 93.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 346.000, 88.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 364.000, 112.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 428.000, 98.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 461.000, 118.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(EnemySprite, Group1Layer2Group , 522.000, 112.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(PlayerSprite, Group1Layer2Group , 311.000, 323.000, 0.000, false, 1, 1, onAddCallback );//"Player"
		}


	}
}
