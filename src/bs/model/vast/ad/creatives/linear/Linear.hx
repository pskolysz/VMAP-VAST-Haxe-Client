package bs.model.vast.ad.creatives.linear;
import bs.interfaces.ICreativeDetails;
import bs.model.vast.ad.creatives.AdParameters;
import bs.model.vast.ad.creatives.Tracking;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Linear implements ICreativeDetails
{

	/**
	 * To specify that a Linear creative can be skipped, the ad server must include the skipoffset attribute in the <Linear> element. The value for skipoffset is a time value in the format HH:MM:SS or HH:MM:SS.mmm or a percentage in the format n%. The .mmm value in the time offset represents milliseconds and is optional. This skipoffset value indicates when the skip control should be provided after the creative begins playing. 
	 */
	public var skipoffset:Float;
	/**
	 * Some ad serving systems may want to send data to the media file when first initialized. For example, the media file may use ad server data to identify the context used to display the creative, what server to talk to, or even which creative to display. The optional <AdParameters> element for the Linear creative enables this data exchange
	 */
	public var adParameters:AdParameters;
	/**
	 * [Requierd] Duration is expressed in the "HH:MM:SS:MMM" format (:MMM represents milliseconds and is optional)
	 */
	public var duration:Float;
	/**
	 * [Requierd] The <MediaFiles> element is a container for one or more <MediaFile> elements, each of which contains a CDATAdwrapped URI to the media file to be downloaded or streamed for the Linear creative. Linear creative are typically video files, but static images may also be used. 
	 */
	public var mediaFiles:Array<MediaFile>;
	/**
	 * A critical function of the video player, when requesting and displaying VAST ads from ad servers, is to send tracking information back to the ad server(s) exactly as specified in the VAST document. Failure to send accurate tracking data renders inconsistent results between video player and ad server counts. 
	 */
	public var trackingEvents:Array<Tracking>;
	/**
	 * A <Linear> element may optionally contain a <VideoClicks> element, which is used to specify what the video player should do if the user clicks directly within the video player frame while the ad is being displayed.  If a <VideoClicks> element is provided, it must contain a single child <ClickThrough> element, and optionally contain one or more child <ClickTracking> and <CustomClick> elements. 
	 */
	public var videoClicks:Array<Click>;
	/**
	 * When the <Icons> element is included in the VAST response, the video player must display the object as an overlay on top of the Linear Ad with which the icon is served and after the ad video has started (i.e. first frame of video is displayed in the player). 
	 */
	public var icons:Array<Icon>;
	
	public function new() 
	{
		
	}
	
}