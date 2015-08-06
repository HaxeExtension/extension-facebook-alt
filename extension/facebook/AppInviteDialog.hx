package extension.facebook;

#if (android && openfl)
import openfl.utils.JNI;
#end

/**
 * ...
 * @author Paul Gene Thompson
 */
class AppInviteDialog {

	/**
	 * Open App Invite Dialog
	 *
	 * @param	appLinkUrl			App Link for what should be opened when the recipient clicks on the install/play button on the app invite page.
	 * @param	previewImageUrl		URL to an image to be used in the invite.
	 */
	public function new(appLinkUrl : String, previewImageUrl : String = "")	{
		#if android
		jni_appInviteDialog(appLinkUrl, previewImageUrl);
		#end
	}

	#if android
	static var jni_appInviteDialog : Dynamic = JNI.createStaticMethod("org.haxe.extension.facebook.AppInviteDialogWrapper", "appInviteDialog", "(Ljava/lang/String;Ljava/lang/String;)V");
	#end
}
