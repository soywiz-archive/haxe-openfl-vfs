package vfs.utils;

import nme.utils.ByteArray;
import nme.utils.Endian;

/**
 * ...
 * @author 
 */

#if cpp
typedef EndianType = String;
#else
typedef EndianType = nme.utils.Endian;
#end

class ByteArrayUtils 
{
	static public function newByteArray(endian:EndianType):ByteArray {
		var byteArray:ByteArray = new ByteArray();
		byteArray.endian = endian;
		return byteArray;
	}
	
	static public function newByteArrayWithLength(length:Int, endian:EndianType):ByteArray {
		#if (cpp || neko)
		var byteArray:ByteArray = new ByteArray(length);
		#else
		var byteArray:ByteArray = new ByteArray();
		byteArray.length = length;
		#end
		byteArray.endian = Endian.LITTLE_ENDIAN;
		return byteArray;
	}
	
	static public function freeByteArray(byteArray:ByteArray):Void {
		byteArray.clear();
	}

	static public function readByteArray(src:ByteArray, count:Int):ByteArray {
		var dst:ByteArray = newByteArray(src.endian);
		if (count > 0) {
			src.readBytes(dst, 0, count);
		}
		dst.position = 0;
		return dst;
	}

	static public function readStringz(data:ByteArray, ?count:Int):String {
		if (count == null) {
			var v:Int;
			var str:String = "";
			while ((v = data.readByte()) != 0) {
				str += String.fromCharCode(v);
			}
			return str;
		} else {
			var string:String = data.readUTFBytes(count);
			var zeroIndex:Int = string.indexOf(String.fromCharCode(0));
			
			return (zeroIndex == -1) ? string : string.substr(0, zeroIndex);
			//return string;
		}
	}

}