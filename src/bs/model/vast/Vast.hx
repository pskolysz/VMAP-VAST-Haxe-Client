package bs.model.vast;
import bs.model.vast.ad.Ad;
import bs.model.vast.ad.Error;
import bs.model.vast.ad.Impression;
import bs.model.vast.ad.Pricing;
/**
 *  @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Vast
{
	/**
	 * vast document version
	 */
	public var version:VastVersion;
	/**
	 * list of ads
	 */
	public var ads:Array<Ad>;
	/**
	 * contains a URI to a tracking resource that the video player should request upon receiving a "no ad" response
	 */
	public var error:Error;
	
	public function new() 
	{
		var a:Ad = new Ad();
		
	}
}

@:enum
abstract VastVersion(String) 
{
	var v_1_0 = "1.0";
	var v_2_0 = "2.0";
	var v_3_0 = "3.0";
}