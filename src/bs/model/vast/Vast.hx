package bs.model.vast;
import bs.model.vast.ad.Ad;
import bs.model.vast.ad.Error;
import bs.model.vast.ad.Impression;
import bs.model.vast.ad.Pricing;
import bs.model.vast.Vast.VastVersion;
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
	
	public static inline function getVersion(vesion:String):VastVersion
	{
		if (!enumMap.exists(vesion))
			return null;
			
		return enumMap.get(vesion);
	}
	
	static var enumMap = ["1.0" => VastVersion.v_1_0,
						"2.0" => VastVersion.v_2_0,
						"3.0" => VastVersion.v_3_0];
}

enum VastVersion
{
	v_1_0;
	v_2_0;
	v_3_0;
	
}