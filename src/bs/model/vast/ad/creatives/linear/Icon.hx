package bs.model.vast.ad.creatives.linear;


/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Icon
{
	public var program:String;
	public var width:Float;
	public var height:Float;
	public var xPosition:Float;
	public var yPosition:Float;
	public var duration:Float;
	public var offset:String;
	public var apiFreamwork:String;
	public var resource:Resource;
	public var iconClicks:Array<Click>;
	/**
	 * contains a URI to a location or file that the video player should request whenthe Icons/Icon creative is displayed to the user
	 */
	public var iconViewTracking:Array<IconViewTracking>;
	
	public function new() 
	{
		
	}
	
}