package vfs;
import flash.errors.Error;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;
import flash.utils.ByteArray;
import vfs.utils.EventUtils;
import vfs.utils.LangUtils;

/**
 * ...
 * @author soywiz
 */

class HttpFileSystem extends VirtualFileSystem
{
	var baseUrl:String;
	
	public function new(baseUrl:String) {
		this.baseUrl = baseUrl;
	}
	
	private function getAbsolutePath(name:String) {
		return ~/\/*$/.replace(baseUrl, '') + '/' + name;
	}
	
	override public function openAsync(name:String, done:Stream -> Void):Void
	{
		var loader:URLLoader = new URLLoader();
		var urlRequest:URLRequest = new URLRequest(getAbsolutePath(name));
		loader.dataFormat = URLLoaderDataFormat.BINARY;
		urlRequest.method = URLRequestMethod.GET;
		//urlRequest.req
		//new URLRequestHeader();
		
		done = LangUtils.callOnce(done);
		
		EventUtils.addEventListenerWeak(loader, Event.COMPLETE, function(e:Event):Void {
			loader.close();
			done(new BytesStream(loader.data));
		});
		EventUtils.addEventListenerWeak(loader, SecurityErrorEvent.SECURITY_ERROR, function(e:Event):Void {
			throw(new Error("SECURITY_ERROR: " + name + " # " + baseUrl));
			loader.close();
			done(null);
		});
		EventUtils.addEventListenerWeak(loader, IOErrorEvent.IO_ERROR, function(e:Event):Void {
			throw(new Error("IO_ERROR: " + name + " # " + baseUrl));
			loader.close();
			done(null);
		});
		
		loader.load(urlRequest);
		//throw(new Error("Not implemented VirtualFileSystem.openAsync"));
	}
	
	override public function existsAsync(name:String, done:Bool -> Void):Void {
		var loader:URLLoader = new URLLoader();
		var urlRequest:URLRequest = new URLRequest(getAbsolutePath(name));
		loader.dataFormat = URLLoaderDataFormat.BINARY;
		//urlRequest.method = URLRequestMethod.HEAD;
		urlRequest.method = URLRequestMethod.GET;
		done = LangUtils.callOnce(done);
		
		EventUtils.addEventListenerWeak(loader, Event.COMPLETE, function(e:Event):Void {
			loader.close();
			done(true);
		});
		EventUtils.addEventListenerWeak(loader, "httpResponseStatus", function(e:HTTPStatusEvent):Void {
			loader.close();
			done((e.status >= 200 && e.status < 400));
		});
		EventUtils.addEventListenerWeak(loader, SecurityErrorEvent.SECURITY_ERROR, function(e:Event):Void {
			loader.close();
			done(false);
		});
		EventUtils.addEventListenerWeak(loader, IOErrorEvent.IO_ERROR, function(e:Event):Void {
			loader.close();
			done(false);
		});
		
		loader.load(urlRequest);
	}
}