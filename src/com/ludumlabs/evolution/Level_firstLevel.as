//Code generated with DAME. http://www.dambots.com

package com.ludumlabs.evolution
{
	import org.flixel.*;
	public class Level_firstLevel extends BaseLevel
	{
		//Embedded media...
		[Embed(source="mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Group1Map1:Class;
		[Embed(source="../../../../tileset.png")] public var Img_Group1Map1:Class;

		//Tilemaps
		public var layerGroup1Map1:FlxTilemap;

		//Sprites
		public var Group1Layer2Group:FlxGroup = new FlxGroup;


		public function Level_firstLevel(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Map1 = new FlxTilemap;
			layerGroup1Map1.loadMap( new CSV_Group1Map1, Img_Group1Map1, 20,20, FlxTilemap.OFF, 0, 1, 3 );
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
			boundsMaxX = 800;
			boundsMaxY = 600;

		}

		override public function addSpritesForLayerGroup1Layer2(onAddCallback:Function = null):void
		{
			addSpriteToLayer(PlayerSprite, Group1Layer2Group , 241.000, 252.000, 0.000, false, 1, 1, onAddCallback );//"Player"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 579.000, 253.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 580.000, 277.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 572.000, 299.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 577.000, 327.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 574.000, 354.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 577.000, 381.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 572.000, 402.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 582.000, 438.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 638.000, 302.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 635.000, 326.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 631.000, 347.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 638.000, 371.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 627.000, 395.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 639.000, 416.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 614.000, 431.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 560.000, 423.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
		}


	}
}
