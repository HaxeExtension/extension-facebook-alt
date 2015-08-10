package org.haxe.extension.facebook;

import java.lang.String;

import com.facebook.share.model.AppInviteContent;
import com.facebook.share.widget.AppInviteDialog;

public class AppInviteDialogWrapper {

	public static void appInviteDialog(String appLinkUrl, String previewImageUrl) {
		
		if (AppInviteDialog.canShow()) {

			AppInviteContent content = new AppInviteContent.Builder()
						.setApplinkUrl(appLinkUrl)
						.setPreviewImageUrl(previewImageUrl)
						.build();

			AppInviteDialog.show(Facebook.instance.mainActivity, content);
		}
	}
	

}
