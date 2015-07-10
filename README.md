# extension-Facebook
OpenFL extension to use Facebook in your app

## Instalation

clone this repo, then use the command below :

```shell
haxelib dev facebook path/to/clone
```

Install the msignal lib as well :
```shell
haxelib install msignal
```

## Use

Add a setenv tag in you project.xml to set your facebook application ID :
```xml
<setenv name="FACEBOOK_APP_ID" value="5898465436219" />
```

Then add the haxelib tag : 

```xml
<haxelib name="facebook" /> 
```

Now you are ready to use the extension in your application.

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
    
    mHelper = new FacebookLoginHelper(onLoggedIn, onLoggedOut, onLogginError, onLoginCancel);
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
    mHelper.login();
  }
  
  function onLogOutClicked(e : MouseEvent) {
    mHelper.logout();
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
  
  function onRequestFail(error : String){
    trace("Request fail : "  + error);
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
