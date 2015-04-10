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

	public function new() 
	{
		mLoginManager = LoginManager.getInstance();
	}
	
	public function init() {
		checkLogInStatus();
	}
	
	function checkLogInStatus() 
	{
		if (mLoginManager.isLoggedIn()) {
			if(onLoggedIn != null) onLoggedIn();
			mLoginManager.OnLoggedOut.addOnce(onLogOut);
		}else {
			if (onLoggedOut != null) onLoggedOut();
			
			mLoginManager.OnLoginSuccess.add(onLogInSuccesse);
			mLoginManager.OnLoginFailed.add(onLogInFail);
			mLoginManager.OnLoginCanceled.add(onLogInCancel);
		}
	}
	
	function removeLogInSlots() {
		mLoginManager.OnLoginSuccess.remove(onLogInSuccesse);
		mLoginManager.OnLoginFailed.remove(onLogInFail);
		mLoginManager.OnLoginCanceled.remove(onLogInCancel);
	}
	
	function onLogInSuccess() {
		if (onLoggedIn != null)
			onLoggedIn();
		removeLogInSlots();
	}
	
	function onLogInFail(e : String) {
		if (onLogInError != null)
			onLogInError();
	}
	
	function onLogInCancel() {
		
	}
	
	
}