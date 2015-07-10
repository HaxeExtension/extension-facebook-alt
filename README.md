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
// Wrote the sample in github edit mode, errors may appear...
import openfl.display.Sprite;
import extension.facebook.LoginHelper;
import openfl.events.MouseEvent;

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
