package extension.facebook;
import msignal.Signal;

#if (android && openfl)
import openfl.utils.JNI;
#end

#if cpp
import cpp.Lib;
#end

/**
 * ...
 * @author Thomas B
 */
class LoginManager
{

	static var mInstance : LoginManager;
	
	public static function getInstance() : LoginManager {
		if (mInstance == null)
			mInstance = new LoginManager();
		return mInstance;
	}
	
	/////////////////////
	
	public var OnLoginSuccess 	: Signal0;
	public var OnLoginFailed 	: Signal1<String>;
	public var OnLoginCanceled	: Signal0;
	public var OnLoggedOut 		: Signal0;
	
	/////////////////////
	
	function new() 
	{
		OnLoginSuccess = new Signal0();
		OnLoginFailed = new Signal1<String>();
		OnLoginCanceled = new Signal0();
		OnLoggedOut = new Signal0();
		
		#if android
		jni_init(this);
		#elseif ios
		objC_init(this);
		#end
	}
	
	public function logInWithReadPermissions(permissions : Array<String>) {
		var paramString = permissions.toString();
		paramString = paramString.substr(1, paramString.length - 2);
		
		#if android
		jni_logInWithReadPermissions(paramString);
		#elseif ios
		objC_logInWithReadPermissions(paramString);
		#end
	}
	
	public function logInWithPublishPermissions(permissions : Array<String>) {
		var paramString = permissions.toString();
		paramString = paramString.substr(1, paramString.length - 2);
		
		#if android
		jni_logInWithPublishPermissions(paramString);
		#end
	}
	
	public function logOut() {
		#if android
		jni_logOut();
		#end
		
		OnLoggedOut.dispatch();
	}
	
	public function isLoggedIn() : Bool {
		var accessToken : AccessToken = AccessToken.getCurrent();
		if (accessToken == null) return false;
		return !accessToken.isExpired();
	}
	
	function loginSuccess() {
		OnLoginSuccess.dispatch();
	}
	
	function loginError(e : String) {
		OnLoginFailed.dispatch(e);
	}
	
	function loginCanceled() {
		OnLoginCanceled.dispatch();
	}
	
	#if android
	static var jni_logInWithReadPermissions : Dynamic = JNI.createStaticMethod("org.haxe.extension.facebook.LogInWrapper", "logInWithReadPermissions", "(Ljava/lang/String;)V");
	static var jni_logInWithPublishPermissions : Dynamic = JNI.createStaticMethod("org.haxe.extension.facebook.LogInWrapper", "logInWithPublishPermissions", "(Ljava/lang/String;)V");
	static var jni_init : Dynamic = JNI.createStaticMethod("org.haxe.extension.facebook.LogInWrapper", "init", "(Lorg/haxe/lime/HaxeObject;)V");
	static var jni_logOut : Dynamic = JNI.createStaticMethod("org.haxe.extension.facebook.LogInWrapper", "logOut" , "()V");
	#elseif ios
	static var objC_logInWithReadPermissions : Dynamic = Lib.load("facebookExt", "loginWithReadPermissions", 1);
	static var objC_init : Dynamic = Lib.load("facebookExt", "init", 1);
	#end
	
}