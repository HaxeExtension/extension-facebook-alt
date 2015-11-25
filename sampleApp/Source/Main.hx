package;


import extension.facebook.AccessToken;
import extension.facebook.FacebookError;
import extension.facebook.LoginHelper;
import extension.facebook.LoginManager;
import extension.facebook.Permission;
import extension.facebook.Request;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.net.URLRequestMethod;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import openfl.utils.ByteArray;


class Main extends Sprite {
	
	var mLogInhelper : LoginHelper;
	
	var mBtnMap : Map<Sprite, Dynamic>;
	var mNbBtn : UInt = 0;
	var mScore : Int = 0;
	
	public function new () {
		
		super ();
	
		mBtnMap = new Map<Sprite, Dynamic>();
		
		mLogInhelper = new LoginHelper(onLoggedIn, onLoggedOut, onLogInFailed, onLogInCanceled );
		mLogInhelper.init();
	}
	
	
	function onLoggedIn() {
		removeBtn();
		
		trace("You are " + AccessToken.getCurrent().getUserId());

		addBtn(mLogInhelper.logOut);
		addBtn(writeStuff);
		addBtn(graphRequest);
	}
	
	function onLoggedOut() {
		removeBtn();
		trace("loggedOut");
			
		addBtn(mLogInhelper.logIn);
	}
	
	function removeBtn() {
		mNbBtn = 0;
		for (key in mBtnMap.keys()) {
			removeChild(key);
			mBtnMap.remove(key);
		}
	}
	
	function addBtn(action : Dynamic) {
		var btn = new Sprite();
		btn.graphics.beginFill(Std.int(Math.random() * 0xffffff));
		btn.graphics.drawRoundRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageWidth / 5, 20, 20);
		btn.graphics.endFill();
		
		mBtnMap[btn] = action;
		
		btn.addEventListener(MouseEvent.MOUSE_UP, onBTNPressed);
		
		btn.y = mNbBtn * btn.height * 1.1;
		
		addChild(btn);
		mNbBtn ++;
	}
	
	function onBTNPressed(e:MouseEvent):Void 
	{
		mBtnMap[e.target](null);
	}
	
	function onLogInFailed(e : String) {
		trace("Error : " + e);
	}
	
	function onLogInCanceled() {
		trace("WHYYYY ?");
	}
	
	function writeStuff() {
		var token = AccessToken.getCurrent();
		if (token.hasPermissions(["publish_actions"]))
			publish();
		else
			Permission.askWrite(["publish_actions"], publish);
	}
	
	function publish() {
		trace("publish stuff");
	}
	
	function graphRequest() 
	{
		var request = new Request(AccessToken.getCurrent().getUserId() + "/picture");
		//request.get(onRequestLoaded, onRequestError);
		//request.loadImage(onImageLoaded, onRequestError);
		
		if (AccessToken.getCurrent().hasPermissions([Permission.PUBLISH_ACTION])) 
			postScore();
		else
			Permission.askWrite([Permission.PUBLISH_ACTION], postScore);
		
		trace("publish level");
	}
	
	function publishLevel() {
		var request = new Request("me/test_app:complete", { level:"https://www.testapp.com/metaComplete" }, URLRequestMethod.POST );
		request.load(onRequestLoaded, onRequestError);
	}
	
	function postScore() {
		mScore += 1;
		var request = new Request("me/scores", { score: mScore }, URLRequestMethod.POST);
		request.load(onRequestLoaded, onRequestError);
		
	}
	
	function publishScore() {
		var request = new Request("me/test_app:complete", { level:"https://www.testapp.com/metaComplete" }, URLRequestMethod.POST );
		request.load(onRequestLoaded, onRequestError);
	}
	
	function onRequestError(error : FacebookError) 
	{
		trace(error.message);
	}
	
	function onRequestLoaded(content : Dynamic) 
	{
		trace(content);
	}
	
	function onImageLoaded(image : BitmapData) {
		var obj = addChild(new Bitmap(image));
		obj.y = 300;
	}
	
}