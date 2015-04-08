package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


class Extension_Facebook {
	
	
	public static function sampleMethod (inputValue:Int):Int {
		
		#if (android && openfl)
		
		var resultJNI = extension_facebook_sample_method_jni(inputValue);
		var resultNative = extension_facebook_sample_method(inputValue);
		
		if (resultJNI != resultNative) {
			
			throw "Fuzzy math!";
			
		}
		
		return resultNative;
		
		#else
		
		return extension_facebook_sample_method(inputValue);
		
		#end
		
	}
	
	
	private static var extension_facebook_sample_method = Lib.load ("extension_facebook", "extension_facebook_sample_method", 1);
	
	#if (android && openfl)
	private static var extension_facebook_sample_method_jni = JNI.createStaticMethod ("org.haxe.extension.Extension_Facebook", "sampleMethod", "(I)I");
	#end
	
	
}