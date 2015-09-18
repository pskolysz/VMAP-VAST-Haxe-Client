package bs.model.vast.ad.creatives;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Resource
{
	public var type:String;
	public var creativeType:String;
	public var url:String;
	
	public function new(resourceType:String) 
	{
		type = resourceType;
	}
	
}