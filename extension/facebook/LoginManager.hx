package extension.facebook;

#if (android && openfl)
import openfl.utils.JNI;
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
	
	////////////////////
	
	public var onLoginSuccess 	: Void -> Void;
	public var onLoginFailed 	: String -> Void;
	public var onLoginCanceled	: Void -> Void;
	
	////////////////////
	
	function new() 
	{
		#if android
		jni_init(this);
		#end
	}
	
	public function logInWithReadPermissions(permissions : Array<String>) {
		var paramString = permissions.toString();
		paramString = paramString.substr(1, paramString.length - 2);
		
		#if android
		jni_logInWithReadPermissions(paramString);
		#end
	}
	
	function loginSuccess() {
		if (onLoginSuccess != null)
			onLoginSuccess;
	}
	
	function loginError(e : String) {
		if (onLoginFailed != null)
			onLoginFailed(e);
	}
	
	function loginCanceled() {
		if (onLoginCanceled != null)
			onLoginCanceled();
	}
	
	#if android
	static var jni_logInWithReadPermissions : Dynamic = JNI.createStaticMethod("org.haxe.extension.facebook.LogInWrapper", "logInWithReadPermissions", "(Ljava/lang/String;)V");
	static var jni_logInWithPublishPermissions : Dynamic = JNI.createStaticMethod("org.haxe.extension.facebook.LogInWrapper", "logInWithPublishPermissions", "(Ljava/lang/String;)V");
	static var jni_init : Dynamic = JNI.createStaticMethod("org.haxe.extension.facebook.LogInWrapper", "init", "(Lorg/haxe/lime/HaxeObject;)V");
	#end
	
}