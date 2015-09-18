package bs.model.vast.ad;

/**
 *  Pricing provides a value that represents a price that can be used by real-time bidding (RTB) systems. VAST is not designed to handle RTB since other methods exist, but this element is offered for custom solutions if needed. If used, the following two attributes must be identified:
 *  -  model: identifies the pricing model as one of “CPM”, “CPC”, “CPE”, or “CPV”.
 *  - currency: the 3-letter ISO-4217 currency symbol that identifies the currency of the value provided (i.e. USD, GBP, etc.…)
 *  If the value provided is to be obfuscated/encoded, publishers and advertisers must negotiate the appropriate mechanism to do so. When included as part of a VAST Wrapper in a chain of Wrappers, only the value offered in the first Wrapper need be considered.
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Pricing
{
	public var price:Float;
	public var model:String;
	public var currency:String;
	
	public function new() 
	{
		
	}
	
}