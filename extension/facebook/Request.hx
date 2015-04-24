package extension.facebook;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Loader;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.events.Event;
import openfl.events.HTTPStatusEvent;
import openfl.events.IOErrorEvent;
import openfl.events.NetStatusEvent;
import openfl.net.URLRequestHeader;
import openfl.net.URLRequestMethod;
import openfl.net.URLVariables;

/**
 * ...
 * @author Thomas B
 */
class Request
{
	
	var mUrl : String;
	var mUrlRequest : URLRequest;
	var mUrlVariables : URLVariables;
	
	var mUrlLoader : URLLoader;
	var mImageLoader : Loader;
	
	var mOnLoadedCallback : Dynamic -> Void;
	var mOnImageLoadedCallback : BitmapData -> Void;
	var mOnErrorCallback : FacebookError -> Void;
	
	var mRequestSucces : Bool;

	public function new(endPoint : String, parameters : Dynamic = null, httpMethod : String = "GET") 
	{
		mUrl = "https://" + Facebook.GRAPH + "/v" + Facebook.API + "/" + endPoint;
		
		if (parameters == null)
			parameters = { };
			
		mUrlRequest = new URLRequest(mUrl);
		mUrlRequest.method = httpMethod;
		
		mUrlVariables = new URLVariables();
		mUrlVariables.access_token = AccessToken.getCurrent().getToken();
		
		for (field in Reflect.fields(parameters)) 
			Reflect.setField(mUrlVariables,field, Reflect.field(parameters, field));
		
		mUrlLoader = new URLLoader();
		mUrlLoader.addEventListener(Event.COMPLETE, onRequestComplete);
		mUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
		mUrlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
		
		mImageLoader = new Loader();
		mImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
		mImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onRequestError);
		mImageLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
	}
	
	private function onHttpStatus(e:HTTPStatusEvent):Void 
	{
		trace(e.status);
	}
	
	private function onRequestError(e:IOErrorEvent):Void 
	{
		var a : FacebookError = {
			code : e.errorID,
			type : "IOError",
			message : e.text
		};
		
		if(mOnErrorCallback != null)
			mOnErrorCallback(a);
	}
	
	private function onRequestComplete(e:Event):Void 
	{
		var answerData : String = mUrlLoader.data;
		
		try {
			var data = Json.parse(answerData);
				
			if (Reflect.hasField(data, "error")) {
				var error : FacebookError = Reflect.field(data, "error");
				if(mOnErrorCallback != null)
					mOnErrorCallback(error);
			}else if(mOnLoadedCallback != null)
				mOnLoadedCallback(data);
		}catch (e : Dynamic) {
			if(mOnLoadedCallback != null)
				mOnLoadedCallback(answerData);
		}
		
	}
	
	private function onImageLoaded(e:Event):Void {
		trace("image loaded");
		var bitmapData : BitmapData = cast(mImageLoader.content, Bitmap).bitmapData;
		mOnImageLoadedCallback(bitmapData);
	}
	
	public function load(onLoaded : Dynamic -> Void = null, onError : FacebookError -> Void = null) {
		mUrlVariables.redirect = false;
		mUrlRequest.data = mUrlVariables;
		
		mOnLoadedCallback = onLoaded;
		mOnErrorCallback = onError;
		
		mUrlLoader.load(mUrlRequest);
	}
	
	public function loadImage(onLoaded : BitmapData -> Void = null, onError : FacebookError -> Void = null) {
		mUrlVariables.redirect = true;
		
		mUrlRequest.url = mUrl + "?loaderhack=.jpg";
		mUrlRequest.data = mUrlVariables;
		
		mOnImageLoadedCallback = onLoaded;
		mOnErrorCallback = onError;
		
		mImageLoader.load(mUrlRequest);
	}
	
}