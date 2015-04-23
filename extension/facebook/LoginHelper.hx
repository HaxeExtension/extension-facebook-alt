package extension.facebook;

/**
 * ...
 * @author Thomas B
 */
class LoginHelper
{
	
	var mLoginManager : LoginManager;
	
	public var onLoggedIn : Void -> Void;
	public var onLoggedOut : Void -> Void;
	public var onLogInError : String -> Void;
	public var onLogInCanceled : Void -> Void; 

	public function new(onLoggedIn : Void -> Void = null, onLoggedOut : Void -> Void = null, onLogInError : String -> Void = null, onLogInCanceled : Void -> Void = null)
	{
		this.onLoggedIn = onLoggedIn;
		this.onLoggedOut = onLoggedOut;
		this.onLogInError = onLogInError;
		this.onLogInCanceled = onLogInCanceled;
		
		mLoginManager = LoginManager.getInstance();
	}
	
	public function init() {
		checkLogInStatus();
	}
	
	public function logIn() {
		var	perms = [Permission.PUBLIC_PROFILE];
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
		
		if (onLoggedIn != null)
			onLoggedIn();
			
		mLoginManager.OnLoginSuccess.remove(onLogInSuccess);
		mLoginManager.OnLoginFailed.remove(onLogInFail);
		mLoginManager.OnLoginCanceled.remove(onLogInCancel);
	
		mLoginManager.OnLoggedOut.add(onLogOut);
	}
	
	function onLogInFail(e : String) {
		if (onLogInError != null)
			onLogInError(e);
	}
	
	function onLogInCancel() {
		if (onLogInCanceled != null)
			onLogInCanceled();
	}
	
	function onLogOut() {
		if (onLoggedOut != null)
			onLoggedOut();
			
		mLoginManager.OnLoggedOut.remove(onLogOut);
		
		mLoginManager.OnLoginSuccess.add(onLogInSuccess);
		mLoginManager.OnLoginFailed.add(onLogInFail);
		mLoginManager.OnLoginCanceled.add(onLogInCancel);
	}
	
	
}