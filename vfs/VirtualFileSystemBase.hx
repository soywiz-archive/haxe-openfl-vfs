package vfs;
import nme.errors.Error;

/**
 * ...
 * @author soywiz
 */

class VirtualFileSystemBase 
{
	public function openAsync(name:String, done:Stream -> Void):Void
	{
		throw(new Error("Not implemented VirtualFileSystem.openAsync"));
	}
	
	public function existsAsync(name:String, done:Bool -> Void):Void
	{
		throw(new Error("Not implemented"));
	}
}