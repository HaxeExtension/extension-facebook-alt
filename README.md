# extension-Facebook
OpenFL extension to use Facebook in your app

**/!\ Android only compatible with legacy build at the moment!**

If you use ios-legacy backend (-Dlegacy), use the legacy branch.

## Instalation

Clone this repo, then use the command below :

```shell
haxelib dev facebook path/to/clone
```

Install the msignal lib as well :
```shell
haxelib install msignal
```

then build the extension :
```shell
lime rebuild facebook ios
```

## Use

Add a setenv tag in you project.xml to set your facebook application ID and application display name:
```xml
<setenv name="FACEBOOK_APP_ID" value="5898465436219" />
<setenv name="FACEBOOK_APP_DISPLAY_NAME" value="TestExtension" />
```

Then add the haxelib tag : 

```xml
<haxelib name="facebook" /> 
```

Now you are ready to use the extension in your application.

#### Android Specific step

##### Key Hashes

Facebook asks for a key hashe when configuring your app for facebook.
Your have to generate a keystore.
Then use the bat in the sample folder to get your keyhase.

#### iOs Specific step

Add these lines in your PROJ-Info.plist template, before the final closing `</dict>`:

```xml
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>fb::ENV_FACEBOOK_APP_ID::</string>
            </array>
        </dict>
    </array>
    <key>FacebookAppID</key>
    <string>::ENV_FACEBOOK_APP_ID::</string>
    <key>FacebookDisplayName</key>
    <string>::ENV_FACEBOOK_DISPLAY_NAME::</string>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSExceptionDomains</key>
        <dict>
            <key>facebook.com</key>
            <dict>
                <key>NSIncludesSubdomains</key>
                <true/>
                <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
                <false/>
            </dict>
            <key>fbcdn.net</key>
            <dict>
                <key>NSIncludesSubdomains</key>
                <true/>
                <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
                <false/>
            </dict>
            <key>akamaihd.net</key>
            <dict>
                <key>NSIncludesSubdomains</key>
                <true/>
                <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
                <false/>
            </dict>
        </dict>
    </dict>
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>fbapi</string>
        <string>fb-messenger-api</string>
        <string>fbauth2</string>
        <string>fbshareextension</string>
    </array>
```

If you don't have an PROJ-Info.plist yet, you can find the default template here:

https://github.com/openfl/lime/blob/master/templates/iphone/PROJ/PROJ-Info.plist

To use it, save it at `templates/iphone/PROJ/PROJ-Info.plist`, and add this line in your project.xml:

```
<template path="templates" />
```

If you use other extennsions that templates that file, you'll have to merge it in yours.

You can as well use the command

```
haxelib run facebook project.xml
```

To apply the change to ther plist file, but you'll need to run it after every lime update or clean build.


## Basic Sample

### Facebook Login

```haxe
// Wrote the samples in github edit mode, errors may appear...
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import extension.facebook.LoginHelper;
import extension.facebook.AccessToken;

class FacebookLoginDemo extends Sprite {

  var mHelper : LoginHelper;
  var mUserId : String;

  function new(){
    super();
    
    mHelper = new LoginHelper(onLoggedIn, onLoggedOut, onLogginError, onLoginCancel);
    mHelper.init(); // this check if the user was loggedIn before, and trigger onLoggedIn if it was the case.
    
    var btnLogIn = new Sprite();
    btnLogIn.graphics.beginFill(0x0000ff);
    btnLogIn.graphics.drawRect(0,0,100,33);
    btnLogIn.addEventListener(MouseEvent.CLICK, onLoginCLicked);
    addChild(btnLogIn);
    
    var btnLogOut = new Sprite();
    btnLogOut.graphics.beginFill(0xff0000);
    btnLogOut.graphics.drawRect(0,0,100,33);
    btnLogOut.addEventListener(MouseEvent.CLICK, onLogOutClicked);
    addChild(btnLogOut);
    btnLogOut.y = 100;
  }
  
  function onLoginClicked(e : MouseEvent) {
    mHelper.logIn();
  }
  
  function onLogOutClicked(e : MouseEvent) {
    mHelper.logOut();
  }
  
  function onLoggedIn(){
    mUserId = AccessToken.getCurrent().getUserId();
    trace("Your user id is : " + mUserId);
  }
  
  function onLoggedOut() {
    trace("logged out");
  }
  
  function onLogginError(e : String) {
    trace("error : "  + e);
  }
  
  function onLoginCancel() {
    trace("You have to log in to use my awesome app.");
  }

}


```

### A Graph Request 

Use this tool to test graph request : https://developers.facebook.com/tools/explorer/

```haxe
  import extension.facebook.Request;

  function getUserName() {
    var params = {
      fields : "id,name"
    }
    
    var request : Request = new Request("me", params);
    request.load(onRequestSuccess, onRequestFail);
  }
  
  function onRequestSuccess(data : Dynamic){
    trace("Your name is : " + data.name);
  }
  
  function onRequestFail(e : FacebookError){
    trace("Request fail : "  + e);
  }
```

### Permissions

```haxe
  import extension.facebook.Request;
  import extension.facebook.Permission;
  
  function askPermission(){
    // try to read user friend list. If we don't have the permission, we ask for it, then perform the request
    Permission.doWithRead([Permission.USER_FRIENDS ], onAccept, onRefused, onError);
    // use doWithWrite if you want some write permissions
  }
  
  function onAccept(){
    var request = new Request("me/friends");
    request.load(onSuccess, onRequestError);
  }
  
  function onSuccess(data : Dynamic){
    trace(data);
  }
  
  function onRequesterror(e : String){
    trace("error : " + e);
  }
  
  function onRefused(){
    trace("Please accept the permission so we can ask gift to your friends :'(");
  }
  
  function onError(){
    trace("Problems!");
  }

```
