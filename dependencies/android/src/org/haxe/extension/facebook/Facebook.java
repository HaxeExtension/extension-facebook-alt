package org.haxe.extension.facebook;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.haxe.extension.Extension;

import com.facebook.CallbackManager;
import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.login.LoginManager;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;


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