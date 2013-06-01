package vfs;

import vfs.Stream;
import haxe.Timer;
import flash.errors.Error;
import flash.utils.ByteArray;

/**
 * ...
 * @author 
 */

class VirtualFileSystem extends VirtualFileSystemBase
{
	public function openBatchAsync(_names:Array<String>, done:Dynamic):Void
	{
		var count:Int = _names.length;
		var names:Array<String> = _names.copy();
		var streams:Array<Stream> = [];
		var partialDone:Void -> Void = null;
		
		partialDone = function() {
			if (names.length == 0) {
				Reflect.callMethod(null, done, streams);
			} else {
				var name = names.shift();
				openAsync(name, function(stream:Stream) {
					streams.push(stream);
					Timer.delay(partialDone, 0);
				});
			}
		};
		
		partialDone();
	}

	public function openAndReadAllAsync(name:String, done:ByteArray -> Void):Void {
		var stream:Stream;
		
		openAsync(name, function(stream:Stream):Void {
			stream.readBytesAsync(stream.length, done);
		});
	}

	public function tryOpenAndReadAllAsync(name:String, done:ByteArray -> Void):Void {
		existsAsync(name, function(exists:Bool) {
			if (!exists) {
				done(null);
			} else {
				openAndReadAllAsync(name, done);
			}
		});
	}
}