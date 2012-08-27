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
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 575.000, 271.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 577.000, 290.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 577.000, 310.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 572.000, 331.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 568.000, 351.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 575.000, 374.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 616.000, 437.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 638.000, 302.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 637.000, 322.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 636.000, 341.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 638.000, 361.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 638.000, 381.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 640.000, 401.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 638.000, 422.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(BaseZombie, Group1Layer2Group , 573.000, 394.000, 0.000, false, 1, 1, onAddCallback );//"Zombie"
			addSpriteToLayer(ZippyZombie, Group1Layer2Group , 634.000, 266.000, 0.000, false, 1, 1, onAddCallback );//"ZippyZombie"
			addSpriteToLayer(ZippyZombie, Group1Layer2Group , 634.000, 224.000, 0.000, false, 1, 1, onAddCallback );//"ZippyZombie"
			addSpriteToLayer(ZippyZombie, Group1Layer2Group , 623.000, 241.000, 0.000, false, 1, 1, onAddCallback );//"ZippyZombie"
			addSpriteToLayer(ZippyZombie, Group1Layer2Group , 622.000, 287.000, 0.000, false, 1, 1, onAddCallback );//"ZippyZombie"
			addSpriteToLayer(ZippyZombie, Group1Layer2Group , 561.000, 234.000, 0.000, false, 1, 1, onAddCallback );//"ZippyZombie"
			addSpriteToLayer(ZippyZombie, Group1Layer2Group , 579.000, 217.000, 0.000, false, 1, 1, onAddCallback );//"ZippyZombie"
			addSpriteToLayer(ZippyZombie, Group1Layer2Group , 563.000, 192.000, 0.000, false, 1, 1, onAddCallback );//"ZippyZombie"
			addSpriteToLayer(ZippyZombie, Group1Layer2Group , 578.000, 173.000, 0.000, false, 1, 1, onAddCallback );//"ZippyZombie"
			addSpriteToLayer(TankZombie, Group1Layer2Group , 563.000, 416.000, 0.000, false, 1, 1, onAddCallback );//"TankZombie"
			addSpriteToLayer(TankZombie, Group1Layer2Group , 563.000, 439.000, 0.000, false, 1, 1, onAddCallback );//"TankZombie"
			addSpriteToLayer(TankZombie, Group1Layer2Group , 600.000, 423.000, 0.000, false, 1, 1, onAddCallback );//"TankZombie"
			addSpriteToLayer(TankZombie, Group1Layer2Group , 596.000, 441.000, 0.000, false, 1, 1, onAddCallback );//"TankZombie"
			addSpriteToLayer(LurkerZombie, Group1Layer2Group , 503.000, 499.000, 0.000, false, 1, 1, onAddCallback );//"LurkerZombie"
			addSpriteToLayer(LurkerZombie, Group1Layer2Group , 752.000, 204.000, 0.000, false, 1, 1, onAddCallback );//"LurkerZombie"
			addSpriteToLayer(LurkerZombie, Group1Layer2Group , 564.000, 30.000, 0.000, false, 1, 1, onAddCallback );//"LurkerZombie"
			addSpriteToLayer(LurkerZombie, Group1Layer2Group , 628.000, 89.000, 0.000, false, 1, 1, onAddCallback );//"LurkerZombie"
			addSpriteToLayer(LurkerZombie, Group1Layer2Group , 697.000, 269.000, 0.000, false, 1, 1, onAddCallback );//"LurkerZombie"
			addSpriteToLayer(LurkerZombie, Group1Layer2Group , 684.000, 342.000, 0.000, false, 1, 1, onAddCallback );//"LurkerZombie"
		}


	}
}
