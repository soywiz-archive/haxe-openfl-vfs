package vfs;

import flash.utils.ByteArray;

/**
 * ...
 * @author 
 */

class Stream extends StreamBase
{
	public function readAllBytesAsync(done:ByteArray -> Void):Void {
		return readBytesAsync(length, done);
	}
}