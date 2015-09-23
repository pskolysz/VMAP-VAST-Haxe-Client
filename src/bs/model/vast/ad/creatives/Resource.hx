package bs.model.vast.ad.creatives;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Resource
{
	public var type:ResourceType;
	public var creativeType:MIMEType;
	public var url:String;
	
	public function new(type:ResourceType) 
	{
		this.type = type;
	}
	
}

@: enum
abstract ResourceType(String)
{
	/**
	 *  Describes non-html creative where an attribute for creativeType is used to identify the creative resource platform. The video player uses the creativeType information to determine how to display the resource
	 */
	var STATIC_RESOURCE = "StaticResource";
	/**
	 * Describes a resource that is an HTML page that can be displayed within an Iframe on the publisher's page
	 */
	var I_FRAME_RESOURCE = "IFrameResource";
	/**
	 * Describes a "snippet" of HTML code to be inserted directly within the publisher's HTML page code.
	 */
	var HTML_RESOURCE = "HTMLResource";
	
}