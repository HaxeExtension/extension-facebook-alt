package extension.facebook;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


class Facebook {
		
	public static inline var API : String = "2.3";
	public static inline var GRAPH : String = "graph.facebook.com";
	
}