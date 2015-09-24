package bs.model.vast.ad;
import bs.model.vast.ad.creatives.Creative;
import haxe.xml.Fast;


/**
 * Within the <VAST> element are one or more <Ad> elements.Advertisers and video content publishers may associate an <Ad> element with a line item video ad defined in contract documentation, usually an insertion order. These line item ads typically specify the creative to display, price, delivery schedule, targeting, and soon.
 * 
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Ad
{	
	/**
	 * [Requierd] an ad server-defined identifier string for the ad
	 */
	public var id:String;
	/**
	 * a number greater than zero (0) that identifies the sequence in which an ad should play; all <Ad> elements with sequence values are part of a pod and are intended to be played in sequence
	 */
	public var sequence:Int;
	/**
	 * [Requierd] the name of the ad server that returned the ad; version is optional
	 */
	public var system:AdSystem;
	/**
	 * [Requierd] the common name of the ad
	 */
	public var title:String;
	/**
	 * a string value that provides a longer description of the ad
	 */
	public var description:String;
	/**
	 * the name of the advertiser as defined by the ad serving party. This element can be used to prevent displaying ads with advertiser competitors. Ad serving parties and publishers should identify how to interpret values provided within this element. As with any optional elements, the video player is not required to support it 
	 */
	public var advertiser:String;
	/**
	 * Pricing provides a value that represents a price that can be used by real-time bidding (RTB) systems. VAST is not designed to handle RTB since other methods exist, but this element is offered for custom solutions if needed. If used, the following two attributes must be identified:
	 *  - model: identifies the pricing model as one of “CPM”, “CPC”, “CPE”, or “CPV”.
	 *  - currency: the 3-letter ISO-4217 currency symbol that identifies the currency of the value provided (i.e. USD, GBP, etc.…)
	 *  If the value provided is to be obfuscated/encoded, publishers and advertisers must negotiate the appropriate mechanism to do so. When included as part of a VAST Wrapper in a chain of Wrappers, only the value offered in the first Wrapper need be considered.
	 */
	public var pricing:Pricing;
	/**
	 * a URI to a survey vendor that could be the survey, a tracking pixel, or anything to do with the survey. Multiple survey elements can be provided. A type attribute is available to specify the MIME type being served. For example, the attribute might be set to type=”text/javascript”. Surveys can be dynamically inserted into the VAST response as long as cross-domain issues are avoided. 
	 */
	public var survey:String;
	/**
	 *  a URI representing an error-tracking pixel; this element can occur multiple times
	 */
	public var errors:Array<Error>;
	/**
	 * [Requierd] the container for one or more Impression elements
	 */
	public var impressions:Array<Impression>;
	/**
	 * [Requierd] the container for one or more Creative elements
	 */
	public var creatives:Array<Creative>;
	/**
	 * XML node for custom extensions, as defined by the ad server. When used, a custom element should be nested under <Extensions> to help separate custom XML elements from VAST elements. The following example includes a custom xml element within the Extensions element.
	 */
	public var extensions:Array<Fast>; 
	
	public function new() 
	{
		
	}
	
}