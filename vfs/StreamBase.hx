package vfs;
import nme.utils.ByteArray;

/**
 * ...
 * @author soywiz
 */

class StreamBase 
{
	public var position:Int;
	public var length:Int;
	
	public function readBytesAsync(length:Int, done:ByteArray -> Void):Void
	{
		throw(Std.format("Not implemented Stream.readBytesAsync : $this"));
	}
}