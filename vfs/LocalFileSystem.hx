package vfs;
import haxe.Log;

#if (cpp || neko)
import sys.FileSystem;

/**
 * ...
 * @author soywiz
 */

class LocalFileSystem extends VirtualFileSystem
{
	var path:String;
	
	public function new(path:String) 
	{
		this.path = path;
	}
	
	override public function openAsync(name:String, done:Stream -> Void):Void 
	{
		done(new FileStream(this.path + "/" + name));
	}
	
	override public function existsAsync(name:String, done:Bool -> Void):Void 
	{
		done(FileSystem.exists(this.path + "/" +name));
	}
}
#end