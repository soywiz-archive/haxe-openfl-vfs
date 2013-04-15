package ;

import haxe.io.Bytes;
import haxe.Log;
import nme.display.Sprite;
import nme.errors.Error;
import nme.events.Event;
import nme.Lib;
import nme.utils.ByteArray;
import nme.utils.Endian;
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
			fs.existsAsync("nmevfs.swf", function (nmevfs_exists:Bool) {
				if (!nmevfs_exists) throw(new Error("Should exists"));

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
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
