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


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerGroup1Map1;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 640;
			boundsMaxY = 480;

		}


	}
}
