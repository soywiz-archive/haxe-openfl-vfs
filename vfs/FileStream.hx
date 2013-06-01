package vfs;
import vfs.utils.ByteUtils;
import vfs.utils.StringEx;
import haxe.io.Bytes;
import haxe.Log;
import flash.errors.Error;
import flash.utils.ByteArray;

#if (cpp || neko)

import sys.FileStat;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileSeek;

/**
 * ...
 * @author soywiz
 */

class FileStream extends Stream
{
	var fileStat:FileStat;
	var fileInput:FileInput;
	var fileName:String;

	public function new(name:String) 
	{
		if (!FileSystem.exists(name)) throw(new Error(Std.format("File '$name' doesn't exist")));
		this.fileName = name;
		this.fileInput = File.read(name);
		this.position = 0;
		this.fileStat = FileSystem.stat(name);
		this.length = fileStat.size;
	}
	
	override public function readBytesAsync(length:Int, done:ByteArray -> Void):Void 
	{
		var bytes:Bytes = null;
		
		//Log.trace(StringEx.sprintf("Reading '%s'(0x%08X:0x%08X)", [this.fileName, this.position, this.position + length]));
		
		try {
			fileInput.seek(position, FileSeek.SeekBegin);
			
			var currentPosition:Int = fileInput.tell();
			if (currentPosition + length > this.length) {
				throw(new Error(Std.format("Trying to read more bytes than available.\nTotal=${this.length}\nCurrentPosition=${currentPosition}\nToRead=${length}")));
			}
			
			bytes = fileInput.read(length);
			
			position += bytes.length;
		} catch (e:Dynamic) {
			Log.trace("Error in readBytesAsync: " + e);
		}
			
		done(ByteUtils.BytesToByteArray(bytes));
	}
	
}

#end