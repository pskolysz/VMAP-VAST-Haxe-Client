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
	/**
	 * an optional identifier for the creative
	 */
	public var id:String;
	/**
	 * [Requierd] the pixel width of the placement slot for which the creative is intended
	 */
	public var width:Float;
	/**
	 * [Requierd] the pixel height of the placement slot for which the creative is intended
	 */
	public var height:Float;
	/**
	 * the pixel width of the creative
	 */
	public var assetWidth:Float;
	/**
	 * the pixel height of the creative
	 */
	public var assetHeight:Float;
	/**
	 * the maximum pixel width of the creative in its expanded state
	 */
	public var expandedWidth:Float;
	/**
	 * the maximum pixel height of the creative in its expanded state
	 */
	public var expandedHeight:Float;
	/**
	 * the API necessary to communicate with the creative if available
	 */
	public var apiFramework:String;
	/**
	 * used to identify desired placement on a publisher’s page; values to be used should be discussed between publishers and advertisers
	 */
	public var adSlotID:String;
	/**
	 * a value of either "all", "any" or "none" identifying whether (and how many) of the companion creative should be displayed with the ad
	 */
	public var required:RequiredType;
	/**
	 * VAST 3.0 allows for multiple resource files in one <Companion> element. The video player should poll the resource files in each <Companion> element to find the most appropriate file to display
	 */
	public var resources:Array<Resource>;
	
	/**
	 * used to pass information to the creative unit; includes the attribute xmlEncoded that is a Boolean value for identifying whether the <AdParameters> value is xml encoded.
	 */
	public var adParameters:AdParameters;
	/**
	 * used to provide an image description that displays when a user mouses over the Companion creative
	 */
	public var altText:String;
	/**
	 * a container for the CompanionClickThrough and CompanionClickTracking
	 */
	public var companionClicks:Array<Click>;
	/**
	 * a container for the <Tracking> element used to track defined metrics defined by the event attribute
	 */
	public var trackingEvents:Array<Tracking>;
	
	
	public function new() 
	{
		
	}
	
}

@:enum 
abstract RequiredType(String)
{
	/**
	 * the video player must attempt to display the contents for all <Companion> elements provided; if all Companion creative cannot be displayed, the Ad should be disregarded and the ad server should be notified using the <Error> elemen
	 */
	var ALL = "all";
	/**
	 * the video player must attempt to display content from at least one of the <Companion> elements provided (i.e. display the one with dimensions that best fit the page); if none of the Companion creative can be displayed, the Ad should be disregarded and the ad server should be notified using the <Error> element
	 */
	var ANY = "any";
	/**
	 * the video player may choose to not display any of the Companion creative, but is not restricted from doing so; the ad server may use this option when the advertiser prefers that the master ad be displayed with or without the Companion creative
	*/
	var NONE = "none";	
}