package extension.facebook;
import openfl.utils.JNI;

/**
 * ...
 * @author Thomas B
 */
class AccessToken
{
	
	static var mCurrentToken : Dynamic;
	
	public static function getCurrent() : AccessToken {
		
		if (mCurrentToken == null)
			mCurrentToken = new AccessToken(null);
		
		#if android
		var token = jni_getCurrentToken();
		if (token != null && token != mCurrentToken) {
			mCurrentToken = token;
			return new AccessToken(token);
		}
		else if (token == mCurrentToken)
			return mCurrentToken;
		else
			return new AccessToken(null);
		#else
		return null;
		#end
	}
	
	var mToken : Dynamic;

	function new(token : Dynamic) 
	{
		mToken = token;
	}
	
	public function isExpired() : Bool {
		
		if (mToken == null)
			return true;
		
		#if android
		return JNI.callMember(jni_isExpired, mToken, []);
		#else
		return true;
		#end
	}
	
	#if android
	static var jni_getCurrentToken : Dynamic = JNI.createStaticMethod("com.facebook.AccessToken", "getCurrentAccessToken", "()Lcom/facebook/AccessToken;");
	
	static var jni_isExpired : Dynamic =  JNI.createMemberMethod("com.facebook.AccessToken", "isExpired", "()Z");
	#end
	
}