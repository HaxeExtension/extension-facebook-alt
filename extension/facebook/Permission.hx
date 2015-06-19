package extension.facebook;

/**
 * ...
 * @author Thomas B
 */
class Permission
{
	
	public static inline var PUBLISH_ACTION : String = "publish_actions";
	public static inline var PUBLIC_PROFILE : String = "public_profile";
	public static inline var USER_FRIENDS : String = "user_friends";
	
	public static var dontAskRefusedPermissionAgain : Bool;
	
	static var mRefusedPermissions : Array<String>;
	static var mAskedPerms : Array<String>;
	static var mAcceptedCB : Dynamic;
	static var mRefusedCB : Dynamic;
	static var mErrorCB : Dynamic;
	
	public static function askWrite(permissions : Array<String>, onAccepted : Dynamic = null, onRefused : Dynamic = null, onError : Dynamic = null) {
		var logManager = prepareLogIn(permissions, onAccepted, onRefused, onError);
		
		if(dontAskRefusedPermissionAgain)
			for(askedPerm in permissions)
				if (mRefusedPermissions.indexOf(askedPerm) != -1)
					return;
				
		logManager.logInWithPublishPermissions(permissions);
	}
	
	public static function askRead(permissions : Array<String>, onAccepted : Dynamic = null, onRefused : Dynamic = null, onError : Dynamic = null) {
		var logManager = prepareLogIn(permissions, onAccepted, onRefused, onError);
		
		if(dontAskRefusedPermissionAgain)
			for(askedPerm in permissions)
				if (mRefusedPermissions.indexOf(askedPerm) != -1)
					return;
		
		logManager.logInWithReadPermissions(permissions);
	}
	
	public static function doWithRead(permission : Array<String>, onAccepted : Dynamic = null, onRefused : Dynamic = null, onError : Dynamic = null) {
		var token = AccessToken.getCurrent();
		if (token.hasPermissions(permission))
			onAccepted();
		else
			askRead(permission, onAccepted, onRefused, onError);
	}
	
	public static function doWithWrite(permission : Array<String>, onAccepted : Dynamic = null, onRefused : Dynamic = null, onError : Dynamic = null) {
		var token = AccessToken.getCurrent();
		if (token.hasPermissions(permission))
			onAccepted();
		else
			askWrite(permission, onAccepted, onRefused, onError);
	}
	
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
		else if (mRefusedCB != null){
			mRefusedCB();
			updateRefusedPermissions();
		}
		reset();
	}
	
	static function onLoginCanceled() {
		if (mRefusedCB != null)
			mRefusedCB();
			
		updateRefusedPermissions();
		
		reset();
	}
	
	static function onLoginError(e : String) {
		if (mErrorCB != null)
			mErrorCB();
		reset();
	}
	
	static function updateRefusedPermissions():Void 
	{
		if (mRefusedPermissions == null)
			mRefusedPermissions = new Array<String>();
		
		for (perm in mAskedPerms)
			if (AccessToken.getCurrent().getPermissions().indexOf(perm) == -1 &&
				mRefusedPermissions.indexOf(perm) == -1)
				mRefusedPermissions.push(perm);
	}
	
}