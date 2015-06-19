package org.haxe.extension.facebook;

import java.util.Set;
import java.lang.String;

import com.facebook.AccessToken;

public class AccessTokenWrapper {

	public static String getPermissions(AccessToken token){
		
		String rep = "";
		
		Set<String> perms = token.getPermissions();
		for(String perm : perms){
			rep += perm + ",";
		}

		return rep;
	}
	
	public static String getDeclinedPermissions(AccessToken token){
		
		String rep = "";
		
		Set<String> perms = token.getDeclinedPermissions();
		for(String perm : perms){
			rep += perm + ",";
		}
		
		return rep;
	}
	

}
