package bs.parser;
import bs.interfaces.ICreativeDetails;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.vast.ad.AdSystem;
import bs.model.vast.ad.creatives.Click;
import bs.model.vast.ad.creatives.companion.Companion;
import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.creatives.CreativeDetails;
import bs.model.vast.ad.creatives.CreativeExtension;
import bs.model.vast.ad.creatives.linear.Linear;
import bs.model.vast.ad.creatives.linear.MediaFile;
import bs.model.vast.ad.creatives.MIMEType.MIMETypeTool;
import bs.model.vast.ad.creatives.nonlinears.NonLinear;
import bs.model.vast.ad.creatives.Tracking;
import bs.model.vast.ad.Impression;
import bs.model.vast.Vast;
import bs.tools.TimeTool;
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
		for (creativeFast in creatives) 
		{
			var creative = new Creative();
			if (creativeFast.has.id) creative.id = creativeFast.att.id;
			if (creativeFast.has.sequence) creative.sequence = Std.parseInt(creativeFast.att.sequence);
			if (creativeFast.has.AdID) creative.adID = creativeFast.att.AdID;
			if (creativeFast.has.apiFramework) creative.apiFramework = creativeFast.att.apiFramework;
			if (creativeFast.hasNode.creativeExtensions) 
				creative.creativeExtensions = getCreativeExtensions(creativeFast.node.CreativeExtensions.nodes.CreativeExtension);
			if (creativeFast.hasNode.Linear) creative.details = cast getLinear(creativeFast.nodes.Linear);
			if (creativeFast.hasNode.CompanionAds) creative.details = cast getCompanionAds(creativeFast.node.CompanionAds.nodes.Companion);
			if (creativeFast.hasNode.NonLinearAds) creative.details  = cast getNonLinearAds(creativeFast.node.NonLinearAds.nodes.NonLinear);
				
			
			trace(creative.details[0]);
			result.push(creative);
		}
		
		return result;
	}
	
	function getNonLinearAds(nonLinears:List<Fast>):Array<NonLinear>
	{
		var result:Array<NonLinear> = new Array<NonLinear>();
		return result;
	}
	
	function getCompanionAds(nonLinears:List<Fast>):Array<Companion>
	{
		var result:Array<Companion> = new Array<Companion>();
		return result;
	}
	
	function getLinear(linears:List<Fast>):Array<Linear> 
	{
		var result:Array<Linear> = new Array<Linear>();
		for (linearFast in linears) 
		{
			var linear:Linear = new Linear();
			linear.duration = TimeTool.convertTimeToSeconds(linearFast.node.Duration.innerData);
			linear.mediaFiles = getMediaFiles(linearFast.node.MediaFiles.nodes.MediaFile);
			
			if (linearFast.has.skipoffset)
				linear.skipoffset = TimeTool.convertOffsetToSeconds(linearFast.att.skipoffset, linear.duration);
			if(linearFast.hasNode.TrackingEvents)
				linear.trackingEvents = getTrackingEvents(linearFast.node.TrackingEvents.nodes.Tracking);
			if(linearFast.hasNode.VideoClicks)
					linear.videoClicks = getVideoClicks(linearFast.node.VideoClicks);
			//linear.adParameters = 
			//linear.icons = 
			
			
			result.push(linear);
			
		}
		
		return result;
	}
	
	function getMediaFiles(mediaFiles:List<Fast>) 
	{
		var result = new Array<MediaFile>();
		for (mediaFileFast in mediaFiles) 
		{
			var mediaFile = new MediaFile(mediaFileFast.att.delivery);
			//requierd
			mediaFile.url = mediaFileFast.innerData;
			mediaFile.type = MIMETypeTool.getType(mediaFileFast.att.delivery);
			mediaFile.width = Std.parseFloat(mediaFileFast.att.width);
			mediaFile.height = Std.parseFloat(mediaFileFast.att.height);
			
			//optional
			if (mediaFileFast.has.apiFramework)
				mediaFile.apiFreamwork = mediaFileFast.att.apiFramework;
			if (mediaFileFast.has.id)
				mediaFile.id = mediaFileFast.att.id;
			if (mediaFileFast.has.bitrate)
				mediaFile.bitrate = Std.parseFloat(mediaFileFast.att.bitrate);
			if (mediaFileFast.has.minBitrate)
				mediaFile.minBitrate = Std.parseFloat(mediaFileFast.att.minBitrate);
			if (mediaFileFast.has.maxBitrate)
				mediaFile.maxBitrate = Std.parseFloat(mediaFileFast.att.maxBitrate);
			if (mediaFileFast.has.scalable)
				mediaFile.scalable = mediaFileFast.att.scalable;
			if (mediaFileFast.has.mantainAspectRatio)
				mediaFile.mantainAspectRatio = (mediaFileFast.att.mantainAspectRatio == "true");
			if (mediaFileFast.has.codec)
				mediaFile.codec = mediaFileFast.att.codec;
			result.push(mediaFile);
		}
		return result;
	}
	
	function getVideoClicks(videoclicksFast:Fast):Array<Click>
	{
		var result = new Array<Click>();
		for (clickThroughFast in  videoclicksFast.nodes.ClickThrough) 
		{
			var clickThrough = new Click(ClickType.CLICK_THROUGH);
			if (clickThroughFast.has.id)
				clickThrough.id = clickThroughFast.att.id;
			clickThrough.url = clickThroughFast.innerData;
			result.push(clickThrough);
		}
		
		for (clickTrackingFast in  videoclicksFast.nodes.ClickTracking) 
		{
			var clickTracking = new Click(ClickType.CLICK_TRACKING);
			if (clickTrackingFast.has.id)
				clickTracking.id = clickTrackingFast.att.id;
			clickTracking.url = clickTrackingFast.innerData;
			result.push(clickTracking);
		}
		
		for (customClickFast in  videoclicksFast.nodes.CustomClick) 
		{
			var customClick = new Click(ClickType.CUSTOM_CLICK);
			if (customClickFast.has.id)
				customClick.id = customClickFast.att.id;
			customClick.url = customClickFast.innerData;
			result.push(customClick);
		}
		
		return result;
	}
	
	function getTrackingEvents(trackingevents:List<Fast>):Array<Tracking>
	{
		var	result = new Array<Tracking>();
		for (trackingFast in trackingevents) 
		{
			var trakcing = new Tracking(trackingFast.att.event);
			trakcing.url = trackingFast.innerData;
			result.push(trakcing);
		}
		
		return result;
	}
	
	function getCreativeExtensions(creativesExtensions:List<Fast>):Array<CreativeExtension>
	{
		var result = new Array<CreativeExtension>();
		
		for (creativeExtensionFast in creativesExtensions) 
		{
			var creativeExtension = new CreativeExtension();
			creativeExtension.type =  MIMETypeTool.getType(creativeExtensionFast.att.type);
			creativeExtension.data = creativeExtensionFast.innerData;
			result.push(creativeExtension);
		}
		
		return result;
	}
	
	function getAdSystem(adSystemFast:Fast):AdSystem
	{
		var adSystem = new AdSystem();
		adSystem.name = adSystemFast.innerData;
		if (adSystemFast.has.version) adSystem.version = adSystemFast.att.version;
		return adSystem;
	}
	
	function getImpressions(impressions:List<Fast>):Array<Impression> 
	{
		var result = new Array<Impression>();
		
		for (impressionFast in impressions) 
		{
			var impression = new Impression();
			if (impressionFast.has.id) impression.id = impressionFast.att.id;
			impression.url = impressionFast.innerData;
		
			result.push(impression);
		}
		
		return result;
	}
	
}