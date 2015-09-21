package bs.parser;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.vast.ad.AdSystem;
import bs.model.vast.ad.creatives.Creative;
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
		Trace.xmlFromString(vastXML.toString());
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
			ad.impressions = getImpressions(adFast.node.InLine.nodes.Impression);
			ad.system = getAdSystem(adFast.node.InLine.node.AdSystem);
			ad.title = adFast.node.InLine.node.AdTitle.innerData;
			ad.creatives = getCreatives(adFast.node.InLine.node.Creatives.nodes.Creative);
			
			
			//Optional
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
	
	function getCreatives(creatives:List<Fast>):Array<Creative>
	{
		var result:Array<Creative> = new Array<Creative>();
		for (crtv in creatives) 
		{
			var creative:Creative = new Creative();
			result.push(creative);
		}
		
		return result;
	}
	
	
	
	function getAdSystem(adSystemFast:Fast):AdSystem
	{
		var adSystem:AdSystem = new AdSystem();
		adSystem.name = adSystemFast.innerData;
		if (adSystemFast.has.version) adSystem.version = adSystemFast.att.version;
		return adSystem;
	}
	
	function getImpressions(impressions:List<Fast>):Array<Impression> 
	{
		var result:Array<Impression> = new Array<Impression>();
		
		for (imp in impressions) 
		{
			var impression:Impression = new Impression();
			if (imp.has.id) impression.id = imp.att.id;
			impression.url = imp.innerData;
		
			result.push(impression);
		}
		
		return result;
	}
	
}