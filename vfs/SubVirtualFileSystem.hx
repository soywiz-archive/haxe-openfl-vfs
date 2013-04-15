package vfs;

/**
 * ...
 * @author soywiz
 */

class SubVirtualFileSystem extends VirtualFileSystem
{
	var parent:VirtualFileSystem;
	var path:String;
	
	private function new(parent:VirtualFileSystem, path:String) {
		this.parent = parent;
		this.path = path;
	}
	
	override public function openAsync(name:String, done:Stream -> Void):Void 
	{
		parent.openAsync(this.path + "/" + name, done);
	}
	
	override public function existsAsync(name:String, done:Bool -> Void):Void 
	{
		parent.existsAsync(this.path + "/" + name, done);
	}
	
	static public function fromSubPath(parent:VirtualFileSystem, path:String):SubVirtualFileSystem {
		return new SubVirtualFileSystem(parent, path);
	}
}