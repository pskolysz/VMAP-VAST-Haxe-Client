package bs.model.vast.ad.creatives;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Click
{	
	public var type:ClickType;
	public var id:String;
	public var url:String;

	public function new(type:ClickType) 
	{
		this.type = type;
	}
	
	public static inline function getType(type:String):ClickType
	{
		if (!enumMap.exists(type))
			return null;
			
		return enumMap.get(type);
	}
	
	static var enumMap = ["ClickThrough" => ClickType.CLICK_THROUGH,
						"ClickTracking" => ClickType.CLICK_THROUGH,
						"CustomClick" => ClickType.CLICK_THROUGH,
						"IconClickThrough" => ClickType.CLICK_THROUGH,
						"IconClickTracking" => ClickType.CLICK_THROUGH,
						"CompanionClickThrough" => ClickType.CLICK_THROUGH,
						"CompanionClickTracking" => ClickType.CLICK_THROUGH,
						"NonLinearClickThrough" => ClickType.CLICK_THROUGH,
						"NonLinearClickTracking" => ClickType.CLICK_THROUGH];
}

enum ClickType 
{
	/**
	 * contains a URI to a page that the video player should request and display in a Web browser window when the user clicks within the video frame while the Linear ad is  played (known as the 	"clickthrough" or "landing page" URI); the server can also use requests to this URI for tracking the "clickthrough" metric
	 */
	CLICK_THROUGH;
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks within the video frame while the Linear ad is played; the server can also use requests to this URI for tracking the “clickthrough” metric
	 */
	CLICK_TRACKING;
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks on a particular button, link, or other call to action associated with the Linear ad during its playback, but which does not open a new page in a Web browser window; the ClickThrough and CustomClick URLs should never be requested at the same time (i.e. for the same click)
	 */
	CUSTOM_CLICK;
	/**
	 * contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the Icon creative that is displayed in association with the ad; may also be used to track the click 
	 */
	ICON_CLICK_THROUGH;
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks on the Icon creative
	 */
	ICON_CLICK_TRACKING;
	/**
	 * contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the companion creative; URI may also be used to track the clickthrough
	 */
	COMPANION_CLICK_THROUGH;
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks on the companion creative; used to track the clickthrough for InLine creative when the creative handles the click; in a Wrapper Ad the URI is used to track clickthroughs for the InLine response that results after the Wrapper
	 */
	COMPANION_CLICK_TRACKING;
	/**
	 * contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the Nonlinear creative; 
	 */
	NON_LINEAR_CLICK_THROUGH;
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks on the Nonlinear creative; used to track an InLine clickthrough when the creative handles the click; in a Wrapper Ad the URI is used to track clickthroughs for the InLine response that results after the Wrapper
	 */
	NON_LINEAR_CLICK_TRACKING;
}