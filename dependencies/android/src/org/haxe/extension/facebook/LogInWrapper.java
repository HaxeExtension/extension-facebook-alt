package org.haxe.extension.facebook;

import org.haxe.lime.HaxeObject;

import android.util.Log;

import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;

public class LogInWrapper {
	
	static HaxeObject mHaxeLogInManager;
	static LoginManager mLoginManager;
	
	public static void init(HaxeObject obj){
		mHaxeLogInManager = obj;
		
		mLoginManager = LoginManager.getInstance();
		
		CallbackManager callbackManager = Facebook.instance.getCallbackManager();
		
		mLoginManager.registerCallback(callbackManager, 
			new FacebookCallback<LoginResult>() {
					
				@Override
				public void onSuccess(LoginResult result) {
					
					AccessToken token = result.getAccessToken();
					
					mHaxeLogInManager.call0("loginSuccess");
				}
				
				@Override
				public void onError(FacebookException error) {
					mHaxeLogInManager.call1("loginError", error.getMessage());				
				}
				
				@Override
				public void onCancel() {
					mHaxeLogInManager.call0("loginCanceled");
				}
			}
		);
	}
	
	public static void logOut() {
		mLoginManager.logOut();
	}

	public static void logInWithReadPermissions(String permissions){
		try {
			mLoginManager.logInWithReadPermissions(Facebook.mainActivity, Facebook.breakParamString(permissions));
		}catch (Exception e){
			Facebook.trace(e.getMessage());
		}
	}
	
	public static void logInWithPublishPermissions(String permissions){
		try {
			mLoginManager.logInWithPublishPermissions(Facebook.mainActivity, Facebook.breakParamString(permissions));
		}catch (Exception e){
			Facebook.trace(e.getMessage());
		}
	}
	
}
