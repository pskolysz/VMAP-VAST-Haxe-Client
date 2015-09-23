package bs.model.vast.ad.creatives.nonlinears;
import bs.interfaces.ICreativeDetails;
import bs.model.vast.ad.creatives.Click;
import bs.model.vast.ad.creatives.Resource;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class NonLinear implements ICreativeDetails 
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
	 * the maximum width in pixels of the creative in its expanded state
	 */
	public var expandedWidth:Float;
	/**
	 * : the maximum height in pixels of the creative in its expanded state
	 */
	public var expandedHeight:Float;
	/**
	 * a Boolean value that identifies whether the creative can scale to new dimensions relative to the video player when the video player is resized
	 */
	public var scalable:Bool;
	/**
	 * a Boolean value the identifies whether the aspect ratio of the creative should be maintained when it is scaled to new dimensions as the video player is resized
	 */
	public var maintainAspectRatio:Bool;
	/**
	 * the minimum suggested duration that the creative should be displayed; duration is in the format HH:MM:SS.mmm (where .mmm is in milliseconds and is optional)
	 */
	public var minSuggestedDuration:Float; 
	/**
	 * the API necessary to communicate with the creative if available
	 */
	public var apiFramework:String;
	/**
	 * Each <NonLinear> element may have one or more resource elements that may be one of: <StaticResource>, <IFrameResource> or <HTMLResource>. Each resource element provides a CDATAdwrapped URI to the creative file to be displayed and describes the type of media used to deliver it. 
	 */
	public var resources:Array<Resource>;
	/**
	 * a container for the NonLinearClickThrough and NonLinearClickTracking
	 */
	public var clicks:Array<Click>;
	/**
	 * used to pass information to the creative unit; includes the attribute xmlEncoded that is a Boolean value for identifying whether the <AdParameters> value is xml encoded.
	 */
	public var adParameters:AdParameters;
	

	public function new() 
	{
		
	}
	
}