package bs.parser;
import bs.interfaces.ICreativeDetails;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.vast.ad.AdSystem;
import bs.model.vast.ad.creatives.AdParameters;
import bs.model.vast.ad.creatives.Click;
import bs.model.vast.ad.creatives.companion.Companion;
import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.creatives.CreativeDetails;
import bs.model.vast.ad.creatives.CreativeExtension;
import bs.model.vast.ad.creatives.linear.Icon;
import bs.model.vast.ad.creatives.linear.IconViewTracking;
import bs.model.vast.ad.creatives.linear.Linear;
import bs.model.vast.ad.creatives.linear.MediaFile;
import bs.model.vast.ad.creatives.MIMEType.MIMETypeTool;
import bs.model.vast.ad.creatives.nonlinears.NonLinear;
import bs.model.vast.ad.creatives.Resource;
import bs.model.vast.ad.creatives.Tracking;
import bs.model.vast.ad.Error;
import bs.model.vast.ad.Impression;
import bs.model.vast.ad.Pricing;
import bs.model.vast.Vast;
import bs.tools.TimeTool;
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
		var result:Vast = new Vast();
		vast = new Fast(vastXML);
		result.version = cast (vast.node.VAST.att.version, VastVersion); 
		result.ads = getAds(vast.node.VAST.nodes.Ad);
		trace(result);
		return result;
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
			if (adFast.node.InLine.hasNode.Advertiser)
				ad.advertiser = adFast.node.InLine.node.Advertiser.innerData;
			if (adFast.node.InLine.hasNode.Description)
				ad.description = adFast.node.InLine.node.Description.innerData;
			if (adFast.node.InLine.hasNode.Error)
				ad.errors = getErrors(adFast.node.InLine.nodes.Error);
			if (adFast.node.InLine.hasNode.Extensions)
				ad.extensions = getExtensions(adFast.node.InLine.node.Extensions);
			if (adFast.node.InLine.hasNode.Pricing)
				ad.pricing = getPricing(adFast.node.InLine.node.Pricing);
			if (adFast.has.sequence)
				ad.sequence = Std.parseInt(adFast.att.sequence);
			if (adFast.node.InLine.hasNode.Survey)
				ad.survey = adFast.node.InLine.node.Survey.innerData;
			
			result.push(ad);
		}
		
		return result;
	}
	
	function getPricing(pricingFast:Fast):Pricing
	{
		var result = new Pricing();
		if (pricingFast.has.currency)
			result.currency = pricingFast.att.currency;
		if (pricingFast.has.model)
			result.model = pricingFast.att.model;
		result.price = Std.parseFloat(pricingFast.innerData);
		return result;
	}
	
	function getExtensions(extensionsFast:Fast):Array<Fast>
	{
		var result = new Array<Fast>();
		for (extensionFast in extensionsFast.elements) 
		{
			result.push(extensionFast);
		}
		return result;
	}
	
	function getErrors(errors:List<Fast>):Array<Error> 
	{
		var result = new Array<Error>();
		for (errorFast in errors ) 
		{
			var error = new Error();
			error.url = errorFast.innerData;
		}
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
			if (creativeFast.hasNode.NonLinearAds) creative.details = cast getNonLinearAds(creativeFast.node.NonLinearAds.nodes.NonLinear);
			
			result.push(creative);
		}
		
		return result;
	}
	
	function getNonLinearAds(nonLinears:List<Fast>):Array<NonLinear>
	{
		var result = new Array<NonLinear>();
		for (nonLinearFast in nonLinears) 
		{
			var nonLinear = new NonLinear();
			//requierd
			nonLinear.resources = getResources(nonLinearFast);
			nonLinear.width = Std.parseFloat(nonLinearFast.att.width);
			nonLinear.height = Std.parseFloat(nonLinearFast.att.height);
			nonLinear.clicks = getClicks(nonLinearFast);
			
			//optional
			if (nonLinearFast.has.expandedWidth)
				nonLinear.expandedWidth =  Std.parseFloat(nonLinearFast.att.expandedWidth);
			if (nonLinearFast.has.expandedHeight)
				nonLinear.expandedHeight = Std.parseFloat(nonLinearFast.att.expandedHeight);
			if (nonLinearFast.has.id)
				nonLinear.id = nonLinearFast.att.id;
			if (nonLinearFast.has.scalable)
				nonLinear.scalable = (nonLinearFast.att.scalable == "true");
			if (nonLinearFast.has.maintainAspectRatio)
				nonLinear.maintainAspectRatio = (nonLinearFast.att.maintainAspectRatio == "true");
			if (nonLinearFast.has.minSuggestedDuration)
				nonLinear.minSuggestedDuration = TimeTool.convertTimeToSeconds(nonLinearFast.att.minSuggestedDuration);
			if (nonLinearFast.has.apiFramework)
				nonLinear.apiFramework = nonLinearFast.att.apiFramework;
			if (nonLinearFast.hasNode.AdParameters)
				nonLinear.adParameters = getAdParameters(nonLinearFast.node.AdParameters);
		}
		return result;
	}
	
	function getCompanionAds(companions:List<Fast>):Array<Companion>
	{
		var result  = new Array<Companion>();
		for (companionFast in companions) 
		{		
			var companion = new Companion();
			//requierd
			companion.width = Std.parseFloat(companionFast.att.width);
			companion.height =Std.parseFloat(companionFast.att.height);
			companion.resources = getResources(companionFast);
			companion.clicks = getClicks(companionFast);
			
			//optional
			if(companionFast.has.id)
				companion.id = companionFast.att.id;
			if (companionFast.has.assetWidth)
				companion.assetWidth = Std.parseFloat(companionFast.att.assetWidth);
			if (companionFast.has.assetHeight)
				companion.assetHeight = Std.parseFloat(companionFast.att.assetHeight);
			if (companionFast.has.expandedWidth)
				companion.expandedWidth = Std.parseFloat(companionFast.att.expandedWidth);
			if (companionFast.has.expandedHeight)
				companion.expandedHeight = Std.parseFloat(companionFast.att.expandedHeight);
			if (companionFast.has.apiFramework)
				companion.apiFramework = companionFast.att.apiFramework;
			if (companionFast.has.adSlotID)
				companion.adSlotID = companionFast.att.adSlotID;
			if (companionFast.has.required)
				companion.required = Companion.getRequierType(companionFast.att.required);
			if (companionFast.hasNode.AdParameters)
				companion.adParameters = getAdParameters(companionFast.node.AdParameters);
			if (companionFast.hasNode.trackingEvents)
				companion.trackingEvents = getTrackingEvents(companionFast.node.trackingEvents.nodes.Tracking);
			if (companionFast.hasNode.AltText)
				companion.altText  = companionFast.node.AltText.innerData;
				
			result.push(companion);
		}
		
		return result;
	}
	
	function getResources(resourcesFast:Fast):Array<Resource> 
	{
		var result = new Array<Resource>();
		
		if (resourcesFast.hasNode.IFrameResource) {
			var iFrameResource = new Resource(ResourceType.I_FRAME_RESOURCE);
			iFrameResource.url = resourcesFast.node.IFrameResource.innerData;
			result.push(iFrameResource);
		}
		if (resourcesFast.hasNode.HTMLResource) {
			var htmlResource = new Resource(ResourceType.HTML_RESOURCE);
			htmlResource.url = resourcesFast.node.HTMLResource.innerData;
			result.push(htmlResource);
		} 
		if(resourcesFast.hasNode.StaticResource) {
			var staticResource = new Resource(ResourceType.STATIC_RESOURCE);
			staticResource.creativeType = MIMETypeTool.getType(resourcesFast.node.StaticResource.att.creativeType);
			staticResource.url = resourcesFast.node.StaticResource.innerData;
			result.push(staticResource);
		}
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
				linear.videoClicks = getClicks(linearFast.node.VideoClicks);
			if(linearFast.hasNode.AdParameters)
				linear.adParameters = getAdParameters(linearFast.node.AdParameters);
			if(linearFast.hasNode.Icons)
				linear.icons = getIcons(linearFast.node.Icons.nodes.Icons);
			result.push(linear);
		}
		return result;
	}
	
	function getIcons(icons:List<Fast>):Array<Icon>
	{
		var result = new Array<Icon>();
		for (iconFast in icons) 
		{
			var icon = new Icon();
			//requierd
			icon.program = iconFast.att.program;
			icon.height = Std.parseFloat(iconFast.att.height);
			icon.width = Std.parseFloat(iconFast.att.width);
			icon.xPosition = Std.parseFloat(iconFast.att.xPosition);
			icon.yPosition = Std.parseFloat(iconFast.att.yPosition);
			icon.resource = getResource(iconFast);
			
			//optional
			if(iconFast.has.apiFramework)
				icon.apiFreamwork = iconFast.att.apiFramework;
			if(iconFast.has.offset)
				icon.offset = TimeTool.convertTimeToSeconds(iconFast.att.offset);
			if(iconFast.has.duration)
				icon.duration = TimeTool.convertTimeToSeconds(iconFast.att.duration);
			if(iconFast.hasNode.IconClicks)
				icon.iconClicks = getClicks(iconFast.node.IconClicks);
			if(iconFast.hasNode.IconViewTracking)
				icon.iconViewTracking = getIconViewTracking(iconFast.nodes.IconViewTracking);
			
			result.push(icon);
		}
		
		return result;
	}
	
	function getIconViewTracking(iconViewTrackings:List<Fast>):Array<IconViewTracking>
	{
		var result = new Array<IconViewTracking>();
		for (iconViewTrackingFast in iconViewTrackings) 
		{
			var iconViewTracking = new IconViewTracking();
			iconViewTracking.url = iconViewTrackingFast.innerData;
			result.push(iconViewTracking);
		}
		
		return result;
	}
	
	function getResource(resourceFast:Fast):Resource
	{
		var result:Resource;
		if (resourceFast.hasNode.IFrameResource) {
			result = new Resource(ResourceType.I_FRAME_RESOURCE);
			result.url = resourceFast.node.IFrameResource.innerData;
		} else if (resourceFast.hasNode.HTMLResource) {
			result = new Resource(ResourceType.HTML_RESOURCE);
			result.url = resourceFast.node.HTMLResource.innerData;
		} else if(resourceFast.hasNode.StaticResource) {
			result = new Resource(ResourceType.STATIC_RESOURCE);
			result.creativeType = MIMETypeTool.getType(resourceFast.node.StaticResource.att.creativeType);
			result.url = resourceFast.node.StaticResource.innerData;
		} else 
			return null;
		
		return result;
	}
	
	function getAdParameters(adParametersFast:Fast):AdParameters
	{
		var adParameters = new AdParameters();
		if(adParametersFast.has.xmlEncoded)
			adParameters.xmlEncoded = (adParametersFast.att.xmlEncoded == "true");
		adParameters.data = adParametersFast.innerData;
		return adParameters;
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
	
	function getClicks(clicksFast:Fast):Array<Click>
	{
		var result = new Array<Click>();
		for (clickThroughFast in  clicksFast.nodes.ClickThrough) 
		{
			var clickThrough = new Click(ClickType.CLICK_THROUGH);
			if (clickThroughFast.has.id)
				clickThrough.id = clickThroughFast.att.id;
			clickThrough.url = clickThroughFast.innerData;
			result.push(clickThrough);
		}
		
		for (clickTrackingFast in  clicksFast.nodes.ClickTracking) 
		{
			var clickTracking = new Click(ClickType.CLICK_TRACKING);
			if (clickTrackingFast.has.id)
				clickTracking.id = clickTrackingFast.att.id;
			clickTracking.url = clickTrackingFast.innerData;
			result.push(clickTracking);
		}
		
		for (customClickFast in  clicksFast.nodes.CustomClick) 
		{
			var customClick = new Click(ClickType.CUSTOM_CLICK);
			if (customClickFast.has.id)
				customClick.id = customClickFast.att.id;
			customClick.url = customClickFast.innerData;
			result.push(customClick);
		}
		
		for (iconClickThroughFast in  clicksFast.nodes.IconClickThrough) 
		{
			var iconClickThrough = new Click(ClickType.ICON_CLICK_THROUGH);
			if (iconClickThroughFast.has.id)
				iconClickThrough.id = iconClickThroughFast.att.id;
			iconClickThrough.url = iconClickThroughFast.innerData;
			result.push(iconClickThrough);
		}
		
		for (iconClickTrackingFast in  clicksFast.nodes.IconClickTracking) 
		{
			var iconClickTracking = new Click(ClickType.ICON_CLICK_TRACKING);
			if (iconClickTrackingFast.has.id)
				iconClickTracking.id = iconClickTrackingFast.att.id;
			iconClickTracking.url = iconClickTrackingFast.innerData;
			result.push(iconClickTracking);
		}
		
		for (nonLinearClickThroughFast in  clicksFast.nodes.NonLinearClickThrough) 
		{
			var nonLinearClickThrough = new Click(ClickType.NON_LINEAR_CLICK_THROUGH);
			if (nonLinearClickThroughFast.has.id)
				nonLinearClickThrough.id = nonLinearClickThroughFast.att.id;
			nonLinearClickThrough.url = nonLinearClickThroughFast.innerData;
			result.push(nonLinearClickThrough);
		}
		
		for (nonLinearClickTrackingFast in  clicksFast.nodes.NonLinearClickTracking) 
		{
			var nonLinearClickTracking = new Click(ClickType.NON_LINEAR_CLICK_TRACKING);
			if (nonLinearClickTrackingFast.has.id)
				nonLinearClickTracking.id = nonLinearClickTrackingFast.att.id;
			nonLinearClickTracking.url = nonLinearClickTrackingFast.innerData;
			result.push(nonLinearClickTracking);
		} 
		
		for (companionClickThroughFast in  clicksFast.nodes.CompanionClickThrough) 
		{
			var companionClickThrough = new Click(ClickType.COMPANION_CLICK_THROUGH);
			if (companionClickThroughFast.has.id)
				companionClickThrough.id = companionClickThroughFast.att.id;
			companionClickThrough.url = companionClickThroughFast.innerData;
			result.push(companionClickThrough);
		}
		
		for (companionClickTrackingFast in  clicksFast.nodes.CompanionClickTracking) 
		{
			var companionClickTracking = new Click(ClickType.COMPANION_CLICK_TRACKING);
			if (companionClickTrackingFast.has.id)
				companionClickTracking.id = companionClickTrackingFast.att.id;
			companionClickTracking.url = companionClickTrackingFast.innerData;
			result.push(companionClickTracking);
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