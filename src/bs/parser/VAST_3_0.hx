package bs.parser;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.vast.ad.AdSystem;
import bs.model.vast.ad.Impression;
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
		trace("parse: VAST_3_0" );
		var data:Vast = new Vast();
		vast = new Fast(vastXML);
		data.version = cast (vast.node.VAST.att.version, VastVersion); 
		data.ads = getAds(vast.node.VAST.nodes.Ad);
		//trace(data);
		return data;
	}
	
	function getAds(ads:List<Fast>):Array<Ad>
	{
		var result:Array<Ad> = new Array<Ad>();
		
		for (adFast in ads) 
		{
			var ad:Ad = new Ad();
			//Requierd
			ad.id = adFast.att.id;
			ad.impressions = getImpressions(adFast);
			ad.system = getAdSystem(adFast);
			//ad.title;
			//ad.creatives;
			
			
			//optional
			trace(ad);
		}
		
		/*for (adXml in vast.node.VAST.nodes.Ad) 
		{
			var ad:Ad = new Ad();
			ad.
		}*/
		
		result.push(new Ad());
		return result;
	}
	
	function getAdSystem(ad:Fast):AdSystem
	{
		var adSystem:AdSystem = new AdSystem();
		adSystem.name = ad.node.InLine.node.AdSystem.innerData;
		if (ad.node.InLine.node.AdSystem.has.version) 
			adSystem.version = ad.node.InLine.node.AdSystem.att.version;
		return adSystem;
	}
	
	function getImpressions(ad:Fast):Array<Impression> 
	{
		var result:Array<Impression> = new Array<Impression>();
		
		for (imp in ad.node.InLine.nodes.Impression) 
		{
			var impression:Impression = new Impression();
			if (imp.has.id) impression.id = imp.att.id;
			impression.url = imp.innerData;
		
			result.push(impression);
		}
		
		return result;
	}
	
}