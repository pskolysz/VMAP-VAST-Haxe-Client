package bs.model.vast.ad;

/**
 * contains a URI to a tracking resource that the video player should request when the ad “impression” metric should be counted, typically when the first frame of the InLine ad is displayed to the user
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Impression
{
	public var url:String;
	public var id:String;
	
	public function new() 
	{
		
	}
	
}