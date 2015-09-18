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
}

@:enum
abstract ClickType(String) 
{
	/**
	 * contains a URI to a page that the video player should request and display in a Web browser window when the user clicks within the video frame while the Linear ad is  played (known as the 	"clickthrough" or "landing page" URI); the server can also use requests to this URI for tracking the "clickthrough" metric
	 */
	var CLICK_THROUGH = "ClickThrough";
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks within the video frame while the Linear ad is played; the server can also use requests to this URI for tracking the “clickthrough” metric
	 */
	var CLICK_TRACKING = "ClickTracking";
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks on a particular button, link, or other call to action associated with the Linear ad during its playback, but which does not open a new page in a Web browser window; the ClickThrough and CustomClick URLs should never be requested at the same time (i.e. for the same click)
	 */
	var CUSTOM_CLICK = "CustomClick";
	/**
	 * contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the Icon creative that is displayed in association with the ad; may also be used to track the click 
	 */
	var ICON_CLICK_THROUGH = "IconClickThrough";
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks on the Icon creative
	 */
	var ICON_CLICK_TRACKING = "IconClickTracking";
	/**
	 * contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the companion creative; URI may also be used to track the clickthrough
	 */
	var COMPANION_CLICK_THROUGH = "CompanionClickThrough";
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks on the companion creative; used to track the clickthrough for InLine creative when the creative handles the click; in a Wrapper Ad the URI is used to track clickthroughs for the InLine response that results after the Wrapper
	 */
	var COMPANION_CLICK_TRACKING = "CompanionClickTracking";
	/**
	 * contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the Nonlinear creative; 
	 */
	var NON_LINEAR_CLICK_THROUGH = "NonLinearClickThrough";
	/**
	 * contains a URI to a location or file that the video player should request when the user clicks on the Nonlinear creative; used to track an InLine clickthrough when the creative handles the click; in a Wrapper Ad the URI is used to track clickthroughs for the InLine response that results after the Wrapper
	 */
	var NON_LINEAR_CLICK_TRACKING = "NonLinearClickTracking";
}