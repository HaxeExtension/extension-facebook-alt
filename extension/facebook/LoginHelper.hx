package extension.facebook;

/**
 * ...
 * @author Thomas B
 */
class LoginHelper
{
	
	var mLoginManager : LoginManager;
	
	public var onLoggedInCB : Void -> Void;
	public var onLoggedOutCB : Void -> Void;
	public var onLogInErrorCB : String -> Void;
	public var onLogInCanceledCB : Void -> Void; 

	public function new(onLoggedIn : Void -> Void = null, onLoggedOut : Void -> Void = null, onLogInError : String -> Void = null, onLogInCanceled : Void -> Void = null)
	{
		onLoggedInCB = onLoggedIn;
		onLoggedOutCB = onLoggedOut;
		onLogInErrorCB = onLogInError;
		onLogInCanceledCB = onLogInCanceled;
		
		mLoginManager = LoginManager.getInstance();
	}
	
	public function init() {
		checkLogInStatus();
	}
	
	public function logIn(additionalsPermissions : Array<String> = null) {
		var	perms : Array<String> = [Permission.PUBLIC_PROFILE];
		if (additionalsPermissions != null)
			perms.concat(additionalsPermissions);
		mLoginManager.logInWithReadPermissions(perms);
	}
	
	public function logOut() {
		mLoginManager.logOut();
	}
	
	function checkLogInStatus() 
	{
		if (mLoginManager.isLoggedIn()) 
			onLogInSuccess();
		else 
			onLogOut();
	}
	
	function onLogInSuccess() {
		if (onLoggedInCB != null)
			onLoggedInCB();
			
		mLoginManager.OnLoginSuccess.remove(onLogInSuccess);
		mLoginManager.OnLoginFailed.remove(onLogInFail);
		mLoginManager.OnLoginCanceled.remove(onLogInCancel);
	
		mLoginManager.OnLoggedOut.add(onLogOut);
	}
	
	function onLogInFail(e : String) {
		if (onLogInErrorCB != null)
			onLogInErrorCB(e);
	}
	
	function onLogInCancel() {
		if (onLogInCanceledCB != null)
			onLogInCanceledCB();
	}
	
	function onLogOut() {
		if (onLoggedOutCB != null)
			onLoggedOutCB();
			
		mLoginManager.OnLoggedOut.remove(onLogOut);
		
		mLoginManager.OnLoginSuccess.add(onLogInSuccess);
		mLoginManager.OnLoginFailed.add(onLogInFail);
		mLoginManager.OnLoginCanceled.add(onLogInCancel);
	}
	
	public function isLoggedIn() {
		return mLoginManager.isLoggedIn();
	}
}