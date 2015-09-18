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
	public var id:String;
	public var width:Float;
	public var height:Float;
	public var expandedWidth:Float;
	public var expandedHeight:Float;
	public var scalable:String;
	public var maintainAspectRatio:String;
	public var minSuggestedDuration:String;
	public var apiFramework:String;
	public var resource:Resource;
	public var click:Array<Click>;
	

	public function new() 
	{
		
	}
	
}