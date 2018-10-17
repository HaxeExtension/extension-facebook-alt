package extension.facebook;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
#if (openfl < "4.0.0")
import openfl.utils.JNI;
#else
import lime.system.JNI;
#end
#end


class Facebook {
		
	public static inline var API : String = "2.3";
	public static inline var GRAPH : String = "graph.facebook.com";
	
}
