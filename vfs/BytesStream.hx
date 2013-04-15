package vfs;
import vfs.utils.ByteArrayUtils;
import nme.errors.Error;
import nme.utils.ByteArray;

/**
 * ...
 * @author soywiz
 */

class BytesStream extends Stream
{
	var byteArray:ByteArray;
	
	public function new(byteArray:ByteArray) {
		this.byteArray = byteArray;
		this.position = 0;
		this.length = byteArray.length;
	}
	
	override public function readBytesAsync(length:Int, done:ByteArray -> Void):Void
	{
		var data:ByteArray;
		byteArray.position = this.position;
		data = ByteArrayUtils.readByteArray(byteArray, length);
		data.position = 0;
		this.position += length;
		done(data);
	}
}