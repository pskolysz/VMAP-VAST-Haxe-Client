package;
import bs.model.vast.ad.Ad;
import bs.model.vast.Vast;
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
		var onVastParseSuccess:Vast->Void = function(data:Vast) { var vast:Vast = data; };
		VASTClient.parseVast(data, onVastParseSuccess, onVastError);
	}
	
	static function onVastError(data:Dynamic):Void 
	{
		Trace.error(data);
	}	
}