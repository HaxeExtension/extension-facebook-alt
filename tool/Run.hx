package ;
import haxe.Template;
import haxe.xml.Fast;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;

class Run {
	
	public static function main() {
		var args : Array<String> = Sys.args();
		
		var projectXmlPath = args[0];
		var workingDir = args[args.length - 1];
		
		var exportPath : String = "";
		var appID : String = "";
		var appDisplayName : String = "";
		var title : String = "";
		
		Sys.setCwd(workingDir);
		
		var fileContent = File.getContent(projectXmlPath);
		
		var xml : Xml = Xml.parse(fileContent);
		var fast: Fast = new Fast(xml.firstElement());
		
		var nodes = fast.nodes;
		for (node in nodes.app)
			if (node.has.path) {
				exportPath = node.att.path;
				break;
			}
			
		for (node in nodes.setenv)
			if (node.att.name == "FACEBOOK_APP_ID")
				appID = node.att.value;
			else if (node.att.name == "FACEBOOK_APP_DISPLAY_NAME")
				appDisplayName = node.att.value;
				
		for (node in nodes.meta)
			if (node.has.title){
				title = node.att.title;
				break;
			}
		
		var error = false;
		
		if (title == "") {
			Sys.println("Could not found title");
			error = true;
		}
				
		if (exportPath == ""){
			Sys.println("Could not found export folder");
			error = true;
		}
		
		if (appID == "") {
			Sys.println("Could not found FACEBOOK_APP_ID in your project.xml");
			error = true;
		}
		
		if (appDisplayName == "") {
			Sys.println("Could not found FACEBOOK_APP_DISPLAY_NAME in your project.xml");
			error = true;
		}
		
		if (error)
			Sys.exit(1);
		else
			addFbInfo(title, exportPath, appID, appDisplayName);
	}
	
	static private function addFbInfo(name:String, exportPath:String, appID:String, appDisplayName:String) {
		
		var plistPath = exportPath + "/ios/" + name + "/" + name + "-Info.plist";
		var plistContent = File.getContent(plistPath);
		
		var xml = Xml.parse(plistContent);
		var dict : Xml = xml.firstElement().firstElement();
		
		var facebookChild = "<key>CFBundleURLTypes</key>" +
							"<array>" +
							"<dict>" +
							"<key>CFBundleURLSchemes</key>" +
							"<array>" +
							"<string>fb::fbid::</string>" +
							"</array>" +
							"</dict>" +
							"</array>" +
							"<key>FacebookAppID</key>" + 
							"<string>::fbid::</string>" +
							"<key>FacebookDisplayName</key>" +
							"<string>::appname::</string>";
							
		var params = { fbid : appID, appname : appDisplayName };
		var tpl = new Template(facebookChild);
		facebookChild = tpl.execute(params);
		
		var facebookChildXml = Xml.parse(facebookChild);
		
		dict.addChild(facebookChildXml);
		
		var file : FileOutput = File.write(plistPath);
		file.writeString(dict.toString());
		file.close();
	}
	
}