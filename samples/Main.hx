package;
import bs.model.Ad;
import bs.parser.VAST_2_0;
import bs.parser.VAST_3_0;
import bs.tools.Trace;
import bs.vast.VASTClient;
import haxe.Constraints.Function;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Main
{
	
	public static function main() 
	{
		VASTClient.getVast("http://localhost/bigsoda/vmap/examples/vast/3.0.xml", onVastLoadSuccess, onVastError);
		
	}
	
	static function onVastLoadSuccess(data:Xml):Void 
	{
		var onVastParseSuccess:Function = function(data:Array<Ad>) 
		{
			var ads:Array<Ad> = data;
		};
		
		VASTClient.parseVast(data, onVastParseSuccess, onVastError);
	}
	
	static function onVastError(data:Dynamic):Void 
	{
		Trace.error(data);
	}
	
	//static function onVastParseSuccess(data:Array<Ad>):Void 
	//{
		//var ads:Array<Ad> = data;
		//trace(ads);
	//}
	
}