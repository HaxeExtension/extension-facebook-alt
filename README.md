# extension-Facebook
OpenFL extension to use Facebook in your app

Only available for Android at the moment.
iOS to come.

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
lime rebuild facebook android
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

**/!\ There is probably a better way to do the following instruction :**

Facebook java api requires at least java 1.7 to build.
In the ```C:\Development\Android SDK\tools\ant\build.xml``` file, replace the lines
```xml
    <property name="java.target" value="1.5" />
    <property name="java.source" value="1.5" />
```
by
```xml
    <property name="java.target" value="1.7" />
    <property name="java.source" value="1.7" />
```

You may need to update your Java JDK http://www.oracle.com/technetwork/java/javase/downloads/index.html and use "openfl setup android" to set the path to the new JDK.

**Please tell me if you know a better way to tell android to build with java 1.7 version**

#### iOs Specific step

You need to add some informations in your project-info.plist to make facebook work with your ios app.
Sadly they get erased everytime you use
```shell
lime update ios
```
or do a clean build.

To make this step easyer I made a simple command to add those informations.
Use 
```shell
haxelib run facebook project.xml
```

After any update or clean build command to add the requiered informations in the plist.

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
    trace("Shit happens");
  }

```
