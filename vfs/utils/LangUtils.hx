package vfs.utils;
import flash.errors.Error;

/**
 * ...
 * @author soywiz
 */

class LangUtils 
{
	static public function callOnce(_callback:Dynamic -> Void):Dynamic -> Void {
		var done:Bool = false;
		return function(value:Dynamic) {
			if (!done) {
				done = true;
				_callback(value);
			}
		};
	}

	static public function tryFinally(action:Void -> Void, finally:Void -> Void) {
		try {
			action();
			finally();
		} catch (e:Error) {
			finally();
			throw(e);
		}
	}
	
	public static function createArray<T>(init:Void->T, len:Int):Array<T> { 
        var ret = new Array<T>(); 
        for (n in 0 ... len) ret.push(init());
        return ret; 
    } 

	public static function createArrayV2<T>(len:Int, init:Int->T):Array<T> { 
        var ret = new Array<T>(); 
        for (n in 0 ... len) ret.push(init(n));
        return ret; 
    } 

	public static function createArray2D<T>(init:Void->T, w:Int, ?h:Int):Array<Array<T>> { 
        if (h == null) h = w; 
        var ret = []; 
        for (i in 0...w) { 
            var row = []; 
            for (j in 0...h) 
                row.push(init()); 
            ret.push(row); 
        } 
        return ret; 
    } 
}