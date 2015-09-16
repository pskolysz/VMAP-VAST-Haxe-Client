package bs.model;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VastError
{
	public static var CODE_100:Dynamic = { code:100, description:"XML parsing error." };
	public static var CODE_101:Dynamic = { code:101, description:"VAST schema validation error." };
	public static var CODE_102:Dynamic = { code:102, description:"VAST version of response not supported." };
	public static var CODE_200:Dynamic = { code:200, description:"Trafficking error. Video player received!an Ad type that it was not expecting and/or cannot display." };
	public static var CODE_201:Dynamic = { code:201, description:"Video player expecting different linearity." };
	public static var CODE_202:Dynamic = { code:202, description:"Video player expecting different duration." };
	public static var CODE_203:Dynamic = { code:203, description:"Video player expecting different size." };
	public static var CODE_300:Dynamic = { code:300, description:"General Wrapper error." };
	public static var CODE_301:Dynamic = { code:301, description:"Timeout of VAST URI provided in Wrapper element, or of VAST URI provided in a subsequent Wrapper element. (URI was either unavailable or reached a timeout as defined by the video player.)" };
	public static var CODE_302:Dynamic = { code:302, description:"Wrapper limit reached, as defined by the video player. Too many Wrapper responses have been received with no InLine response." };
	public static var CODE_303:Dynamic = { code:303, description:"No Ads VAST response after one or more Wrappers." };
	public static var CODE_400:Dynamic = { code:400, description:"General Linear error. Video player is unable to display the Linear Ad." };
	public static var CODE_401:Dynamic = { code:401, description:"File not found. Unable to find Linear/MediaFile from URI." };
	public static var CODE_402:Dynamic = { code:402, description:"Timeout of MediaFile URI." };
	public static var CODE_403:Dynamic = { code:403, description:"Couldn't find MediaFile that is supported by this video!player, based on the attributes of the MediaFile element." };
	public static var CODE_405:Dynamic = { code:405, description:"Problem displaying MediaFile. Video player found a MediaFile with supported type but couldn't display it. MediaFile may include: unsupported codecs, different MIME type than MediaFile@type, unsupported delivery method, etc." };
	public static var CODE_500:Dynamic = { code:500, description:"General NonLinearAds error." };
	public static var CODE_501:Dynamic = { code:501, description:"Unable to display NonLinear Ad because creative dimensions do not align with creative display area (i.e. creative dimension too large)." };
	public static var CODE_502:Dynamic = { code:502, description:"Unable to fetch NonLinearAds/NonLinear resource." };
	public static var CODE_503:Dynamic = { code:503, description:"Couldn’t find NonLinear resource with supported type." };
	public static var CODE_600:Dynamic = { code:600, description:"General CompanionAds error." };
	public static var CODE_601:Dynamic = { code:601, description:"Unable to display Companion because creative dimensions do not fit within Companion display area (i.e., no available space)." };
	public static var CODE_602:Dynamic = { code:602, description:"Unable to display Required Companion." };
	public static var CODE_603:Dynamic = { code:603, description:"Unable to fetch CompanionAds/Companion resource." };
	public static var CODE_604:Dynamic = { code:604, description:"Couldn’t find Companion resource with supported type." };
	public static var CODE_900:Dynamic = { code:900, description:"Undefined Error." };
	public static var CODE_901:Dynamic = { code:901, description:"General VPAID error." };
 
	public function new() 
	{
		
	}
	
}