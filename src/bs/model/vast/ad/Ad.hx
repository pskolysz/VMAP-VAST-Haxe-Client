package bs.model.vast.ad;
import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.extensions.Extension;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Ad
{	
	public var id:String;
	public var sequence:Int;
	public var system:AdSystem;
	public var title:String;
	public var description:String;
	public var advertiser:String;
	public var pricing:Pricing;
	public var survey:String;
	public var errors:Array<Error>;
	public var impressions:Array<Impression>;
	public var creatives:Array<Creative>;
	public var extensions:Array<Extension>;
	
	public function new() 
	{
		
	}
	
}