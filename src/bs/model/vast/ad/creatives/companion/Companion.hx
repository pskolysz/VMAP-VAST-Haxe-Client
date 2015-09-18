package bs.model.vast.ad.creatives.companion;
import bs.interfaces.ICreativeDetails;
import bs.model.vast.ad.creatives.AdParameters;
import bs.model.vast.ad.creatives.Resource;
import bs.model.vast.ad.creatives.Tracking;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Companion implements ICreativeDetails
{
	public var id:String;
	public var width:Float;
	public var height:Float;
	public var assetWidth:Float;
	public var assetHeight:Float;
	public var expandedWidth:Float;
	public var expandedHeight:Float;
	public var apiFramework:String;
	public var adSlotID:String;
	public var resource:Resource;
	public var adParameters:AdParameters;
	public var altText:String;
	public var companionClicks:Array<Click>;
	public var trackingEvents:Array<Tracking>;
	
	
	public function new() 
	{
		
	}
	
}