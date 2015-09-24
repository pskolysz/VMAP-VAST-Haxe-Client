package bs.model.vast.ad.creatives;
import bs.interfaces.ICreativeDetails;
import bs.model.vast.ad.creatives.companion.Companion;
import bs.model.vast.ad.creatives.linear.Linear;
import bs.model.vast.ad.creatives.nonlinears.NonLinear;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Creative
{
	/**
	 * an ad server-defined identifier for the creative
	 */
	public var id:String;
	/**
	 * the numerical order in which each sequenced creative should display (not to be confused with the <Ad> sequence attribute used to define Ad Pods)
	 */
	public var sequence:Int;
	/**
	 * identifies the ad with which the creative is served
	 */
	public var adID:String;
	/**
	 * the technology used for any included API
	 */
	public var apiFramework:String;
	/**
	 * the container for one or more CreativeExtension elements
	 */
	public var creativeExtensions:Array<CreativeExtension>;
	/**
	 * list one of Linear, Companion or NonLinear
	 */
	public var details:Array<CreativeDetails>;
	
	public function new() 
	{
		
	}
	
}