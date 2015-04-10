package org.haxe.extension.facebook;

import com.facebook.AccessToken;

public class AccessTokenWrapper {

	public static AccessToken getCurrentToken() {
		try {
			return AccessToken.getCurrentAccessToken();
		}catch (Exception e){
			Facebook.trace("erreur : " + e.getMessage());
		}
		return null;
	}
	
}
