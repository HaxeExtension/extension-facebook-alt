package extension.facebook;

/**
 * ...
 * @author Thomas B
 */
class Permission
{
	
	public static function askWrite(permissions : Array<String>, onAccepted : Dynamic = null, onRefused : Dynamic = null, onError : Dynamic = null) {
		var logManager = prepareLogIn(permissions, onAccepted, onRefused, onError);
		logManager.logInWithPublishPermissions(permissions);
	}
	
	
	public static function askRead(permissions : Array<String>, onAccepted : Dynamic = null, onRefused : Dynamic = null, onError : Dynamic = null) {
		var logManager = prepareLogIn(permissions, onAccepted, onRefused, onError);
		logManager.logInWithReadPermissions(permissions);
	}
	
	static var mAskedPerms : Array<String>;
	
	static var mAcceptedCB : Dynamic;
	static var mRefusedCB : Dynamic;
	static var mErrorCB : Dynamic;
	
	static function prepareLogIn(perms : Array<String>, onAccepted : Dynamic = null, onRefused : Dynamic = null, onError : Dynamic = null) {
		var logManager = LoginManager.getInstance();
		mAskedPerms = perms;
		
		mAcceptedCB = onAccepted;
		mRefusedCB = onRefused;
		mErrorCB = onError;
		
		logManager.OnLoginSuccess.addOnce(onLoginSuccess);
		logManager.OnLoginCanceled.addOnce(onLoginCanceled);
		logManager.OnLoginFailed.addOnce(onLoginError);
			
		return logManager;
	}
	
	static function reset() {
		mAskedPerms = [];
		
		mAcceptedCB = null;
		mRefusedCB = null;
		mErrorCB = null;
		
		var logManager = LoginManager.getInstance();
		
		logManager.OnLoginSuccess.remove(onLoginSuccess);
		logManager.OnLoginCanceled.remove(onLoginCanceled);
		logManager.OnLoginFailed.remove(onLoginError);
	}
	
	static function onLoginSuccess() {
		var token = AccessToken.getCurrent();
		if (token.hasPermissions(mAskedPerms))
			if (mAcceptedCB != null)
				mAcceptedCB();
		else if (mRefusedCB != null)
			mRefusedCB();
		reset();
	}
	
	static function onLoginCanceled() {
		if (mRefusedCB != null)
			mRefusedCB();
		reset();
	}
	
	static function onLoginError(e : String) {
		if (mErrorCB != null)
			mErrorCB();
		reset();
	}
	
}