package vfs.utils;
import flash.errors.Error;
import flash.events.IEventDispatcher;

/**
 * ...
 * @author soywiz
 */

class EventUtils 
{
	static public function addEventListenerWeak(target : IEventDispatcher, type : String, listener : Dynamic -> Void, useCapture : Bool = false, priority : Int = 0) {
		target.addEventListener(type, listener, useCapture, priority, true);
	}
	
	static private function dummy(e:Dynamic -> Void) {}

	static public function addEventListenerOnce(target : IEventDispatcher, type : String, listener : Dynamic -> Void, useCapture : Bool = false, priority : Int = 0) {
		var listenerOnce: Dynamic -> Void = dummy;
		listenerOnce = function(e:Dynamic):Void {
			target.removeEventListener(type, listenerOnce, useCapture);
			listener(e);
		};
		target.addEventListener(type, listenerOnce, useCapture, priority, true);
	}
}