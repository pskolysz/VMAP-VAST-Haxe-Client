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
	
	public static inline function getType(type:String):ResourceType
	{
		if (!enumMap.exists(type))
			return null;
			
		return enumMap.get(type);
	}
	
	
	static var enumMap = ["StaticResource" => ResourceType.STATIC_RESOURCE,
						"IFrameResource" => ResourceType.I_FRAME_RESOURCE,
						"HTMLResource" => ResourceType.HTML_RESOURCE];
}

enum ResourceType
{
	/**
	 *  Describes non-html creative where an attribute for creativeType is used to identify the creative resource platform. The video player uses the creativeType information to determine how to display the resource
	 */
	STATIC_RESOURCE;
	/**
	 * Describes a resource that is an HTML page that can be displayed within an Iframe on the publisher's page
	 */
	I_FRAME_RESOURCE;
	/**
	 * Describes a "snippet" of HTML code to be inserted directly within the publisher's HTML page code.
	 */
	HTML_RESOURCE;
	
}