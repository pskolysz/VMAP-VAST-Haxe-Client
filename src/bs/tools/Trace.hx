package bs.tools;
import js.html.DOMParser;
import js.html.SupportedType;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Trace
{

	public function new() 
	{
		
	}
	
	public static inline function error(o:Dynamic):Void
	{
		#if js
		untyped __js__("console").error(o);
		#else
		trace(o);
		#end
	}
	
	#if debug
	/**
	 * Trace in conosole Xml in nice view.
	 * @param	xml - string with xml file.
	 */
	public static inline function xmlFromString(xml:String):Void 
	{
		
		#if js
		var parser = new DOMParser(); 
		var htmlDoc = parser.parseFromString(xml.toString(), SupportedType.TEXT_XML);
		untyped __js__("console").log(htmlDoc.documentElement);
		#else
		trace(xml);
		#end
	}
	
	/**
	 * Trace log in colors. Not suporrted in IE.
	 * @param	o - data to print
	 * @param	background - background color
	 * @param	color font color
	 */
	public static inline function logColor(o:Dynamic, ?background:String = "#222", ?color:String = "#bada55"):Void
	{
		#if js
		untyped __js__("console").log( "%c" +o, "background: "+background+"; color: "+color);
		#else
		trace(o);
		#end
	}
	
	public static inline function log(o:Dynamic):Void 
	{
		#if js
		untyped __js__("console").log(o);
		#else
		trace(o);
		#end
	}
	
	
	public static inline function warn(o:Dynamic):Void
	{
		#if js
		untyped __js__("console").warn(o);
		#else
		trace(o);
		#end
	}

	public static inline function info(o:Dynamic):Void
	{
		#if js
		untyped __js__("console").info(o);
		#else
		trace(o);
		#end
	}

	public static inline function debug(o:Dynamic):Void
	{
		#if js
		untyped __js__("console").debug(o);
		#else
		trace(o);
		#end
	}
	#end
	
}