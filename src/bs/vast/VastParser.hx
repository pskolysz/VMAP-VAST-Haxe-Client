package bs.vast;
import bs.interfaces.IParser;
import bs.model.Ad;
import bs.parser.Wrapper;
import bs.tools.Trace;
import haxe.CallStack;
import haxe.Constraints.Function;
import js.html.DOMParser;
import js.html.SupportedType;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VastParser
{
	/*TODO followAdditonalWrappers
	a Boolean value that identifies whether subsequent wrappers after a
	requested VAST response is allowed. If false, any Wrappers received (i.e. not an Inline VAST response)
	should be ignored. Otherwise, VAST Wrappers received should be accepted.
	*/
	
	/*TODO  allowMultipleAds
	a Boolean value that identifies whether multiple ads are allowed in the
	requested VAST response. If true, both Pods and stand-alone ads are allowed. If false, only the first
	stand-alone Ad (i.e. no sequence value for the Ad) in the requested VAST response is allowed.*/
	
	/*TODO fallbackOnNoAd
	a Boolean value that provides instruction for using an available Ad when the
	requested VAST response returns no ads. If true, the video player should select from any stand-alone
	ads available. If false and the Wrapper represents an Ad in a Pod, the video player should move on to
	the next Ad in a Pod; otherwise, the video player can follow through at its own discretion where no-ad
	responses are concerned.*/
	
	static var vast:Xml;
	public function new() 
	{
		
	}
	
	/**
	 * Parsing the VAST Xml to VAST Model
	 * @param	vast VAST Xml
	 * @param	parser class of VAST Version - 1.0, 2.0, 3.0, must implement parser interface.
	 */
	public static function parse(vast:Xml, parserType:Class<IParser>,  success:Array<Ad>->Void, error:Dynamic->Void):Void
	{	
		var parser:IParser = cast Type.createInstance(parserType, []);
		Wrapper.check(vast, function (data:Xml) { success(parser.parse(data)); }, error, onWrapperWarn);
	}
	
	static function onWrapperWarn(data:Dynamic):Void 
	{
		
	}
}