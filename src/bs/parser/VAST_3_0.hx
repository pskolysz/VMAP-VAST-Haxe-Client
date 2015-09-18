package bs.parser;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.vast.Vast;
import bs.tools.Trace;
import haxe.Constraints.Function;
import haxe.xml.Fast;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VAST_3_0 implements IParser
{
	var vast:Fast;
	public function new() 
	{
		
	}
	
	public function parse(vastXML:Xml):Vast
	{
		var data:Vast = new Vast();
		vast = new Fast(vastXML);
		data.version = cast (vast.node.VAST.att.version, VastVersion); 
		data.ads = getAds();
		trace(data);
		return data;
	}
	
	function getAds():Array<Ad>
	{
		var result:Array<Ad> = new Array<Ad>();
		result.push(new Ad());
		return result;
	}
	
}