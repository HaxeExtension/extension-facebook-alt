package org.haxe.extension.facebook;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.List;

import org.haxe.extension.Extension;

import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.Signature;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;

import com.facebook.CallbackManager;
import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsLogger;


/* 
	You can use the Android Extension class in order to hook
	into the Android activity lifecycle. This is not required
	for standard Java code, this is designed for when you need
	deeper integration.
	
	You can access additional references from the Extension class,
	depending on your needs:
	
	- Extension.assetManager (android.content.res.AssetManager)
	- Extension.callbackHandler (android.os.Handler)
	- Extension.mainActivity (android.app.Activity)
	- Extension.mainContext (android.content.Context)
	- Extension.mainView (android.view.View)
	
	You can also make references to static or instance methods
	and properties on Java classes. These classes can be included 
	as single files using <java path="to/File.java" /> within your
	project, or use the full Android Library Project format (such
	as this example) in order to include your own AndroidManifest
	data, additional dependencies, etc.
	
	These are also optional, though this example shows a static
	function for performing a single task, like returning a value
	back to Haxe from Java.
*/
public class Facebook extends Extension {
	
	
	public static Facebook instance;
	
	CallbackManager mCallbackManager;
	
	static List<String> breakParamString(String params){
		return Arrays.asList(params.split(","));
	}
	
	static void trace(String message){
		Log.i("trace","extension-facebook : " + message);
	}
	
	@Override
	public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
		mCallbackManager.onActivityResult(requestCode, resultCode, data);
		return super.onActivityResult(requestCode, resultCode, data);
	}

	public CallbackManager getCallbackManager() {
		return mCallbackManager;
	}
	
	/**
	 * Called when the activity is starting.
	 */
	public void onCreate (Bundle savedInstanceState) {
		
		super.onCreate(savedInstanceState);
		
		instance = this;
		
		FacebookSdk.sdkInitialize(mainContext);
		mCallbackManager = CallbackManager.Factory.create();
		
		
		PackageInfo info;
		try {
			info = mainActivity.getPackageManager().getPackageInfo(
					"::APP_PACKAGE::",
					PackageManager.GET_SIGNATURES);
			
			for (Signature signature : info.signatures){
				MessageDigest md = MessageDigest.getInstance("SHA");
				md.update(signature.toByteArray());
				trace("keyHash " + Base64.encodeToString(md.digest(), Base64.DEFAULT));
			}
			
		} catch (NameNotFoundException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * Called as part of the activity lifecycle when an activity is going into
	 * the background, but has not (yet) been killed.
	 */
	public void onPause () {
		
		AppEventsLogger.deactivateApp(mainContext);
		
	}
	
	
	/**
	 * Called after {@link #onRestart}, or {@link #onPause}, for your activity 
	 * to start interacting with the user.
	 */
	public void onResume () {
		
		AppEventsLogger.activateApp(mainContext);
		
	}
	
}