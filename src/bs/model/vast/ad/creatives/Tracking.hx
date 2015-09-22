package bs.model.vast.ad.creatives;

/**
 * contains a URI to a tracking resource that the video player should request when a specific named event occurs during the playback of the Linear creative (the event name is passed as an attribute of this element); the server can use requests to this URL for tracking metrics associated with specified events
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Tracking
{
	public var url:String;
	public var event:TrackingEvent;
	public function new(type:String) 
	{
		event = cast stringToEnum(type, TrackingEvent);
	}
	
	function stringToEnum<T>(type:String, en:T):T 
	{
		for (i in Reflect.fields(en)) {
			if (i == type)
				return Reflect.getProperty(en, i);
		}
		
		return null;
	}
}

enum TrackingEvent 
{
	/**
	 * not to be confused with an impression, this event indicates that an individual creative portion of the ad was viewed. An impression indicates the first frame of the ad was displayed; however an ad may be composed of multiple creative, or creative that only play on some platforms and not others. This event enables ad servers to track which ad creative are viewed, and therefore, which platforms are more common.
	 */
	creativeView;
	/**
	 * this event is used to indicate that an individual creative within the ad was loaded and playback began. As with creativeView, this event is another way of tracking creative playback.
	 */
	start;
	/**
	 * the creative played for at least 25% of the total duration
	 */
	firstQuartile;
	/**
	 * the creative played for at least 50% of the total duration
	 */
	midpoint;
	/**
	 * the creative played for at least 75% of the duration
	 */
	thirdQuartile;
	/**
	 * The creative was played to the end at normal speed
	 */
	complete;
	/**
	 * the user activated the mute control and muted the creative
	 */
	mute;
	/**
	 * the user activated the mute control and unmuted the creative
	 */
	unmute;
	/**
	 * the user clicked the pause control and stopped the creative
	 */
	pause;
	/**
	 * the user activated the rewind control to access a previous point in the creative timeline
	 */
	rewind;
	/**
	 * the user activated the resume control after the creative had been stopped or paused
	 */
	resume;
	/**
	 * the user activated a control to extend the video player to the edges of the viewer's screen
	 */
	fullscreen;
	/**
	 * the user activated the control to reduce video player size to original dimensions
	 */
	exitFullscreen;
	/**
	 * the user activated a control to expand the creative
	 */
	expand;
	/**
	 * the user activated a control to reduce the creative to its original dimensions
	 */
	collapse;
	/**
	 * the user activated a control that launched an additional portion of the creative. The name of this event distinguishes it from the existing “acceptInvitation” event described in the 2008 IAB Digital Video In-Stream Ad Metrics Definitions, which defines the "acceptInivitation" metric as applying to non-linear ads only. The “acceptInvitationLinear” event extends the metric for use in Linear creative
	 */
	acceptInvitationLinear;
	/**
	 * the user clicked the close button on the creative. The name of this event distinguishes it from the existing “close” event described in the 2008 IAB Digital Video In-Stream Ad Metrics Definitions, which defines the "close" metric as applying to non-linear ads only. The "closeLinear" event extends the "close" event for use in Linear creative
	 */
	closeLinear;
	/**
	 * the user activated a skip control to skip the creative, which is a different control than the one used to close the creative.
	 */
	skip;
	/**
	 * the creative played for a duration at normal speed that is equal to or greater than the value provided in an additional attribute for offset. Offset values can be time in the format HH:MM:SS or HH:MM:SS.mmm or a percentage value in the format n%. Multiple progress events with different values can be used to track multiple progress points in the Linear creative timeline
	 */
	progress;
}