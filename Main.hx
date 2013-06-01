package ;

import haxe.io.Bytes;
import haxe.Log;
import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.Lib;
import flash.utils.ByteArray;
import flash.utils.Endian;
import vfs.HttpFileSystem;
import vfs.VirtualFileSystem;

/**
 * ...
 * @author soywiz
 */

class Main extends Sprite 
{
	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) 
	{
		#if flash
			var fs:VirtualFileSystem = new HttpFileSystem("./");
			fs.existsAsync("openflvfs.swf", function (openflvfs_exists:Bool) {
				if (!openflvfs_exists) throw(new Error("Should exists"));

				fs.existsAsync("INVALIDFILE.swf", function (invalidfile_exists:Bool) {
					if (invalidfile_exists) throw(new Error("Should not exists"));
				});
			});
		#else
		#end
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		stage.align = flash.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
