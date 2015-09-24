package bs.model.vast.ad.creatives;

/**
 * contains a URI to a tracking resource that the video player should request when a specific named event occurs during the playback of the Linear creative (the event name is passed as an attribute of this element); the server can use requests to this URL for tracking metrics associated with specified events
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Tracking
{
	public var url:String;
	public var event:TrackingEvent;
	public function new(event:TrackingEvent) 
	{
		this.event = event;
	}
	public static inline function getType(type:String):TrackingEvent
	{
		if (!enumMap.exists(type))
			return null;
			
		return enumMap.get(type);
	}
	
	static var enumMap = ["creativeView" => TrackingEvent.CREATIVE_VIEW,
						"start" => TrackingEvent.START,
						"firstQuartile" => TrackingEvent.FIRST_QUARTILE,
						"midpoint" => TrackingEvent.MIDPOINT,
						"thirdQuartile" => TrackingEvent.THIRD_QUARTILE,
						"complete" => TrackingEvent.COMPLETE,
						"mute" => TrackingEvent.MUTE,
						"unmute" => TrackingEvent.UNMUTE,
						"pause" => TrackingEvent.PAUSE,
						"rewind" => TrackingEvent.REWIND,
						"resume" => TrackingEvent.RESUME,
						"fullscreen" => TrackingEvent.FULLSCREEN,
						"exitFullscreen" => TrackingEvent.EXIT_FULLSCREEN,
						"expand" => TrackingEvent.EXPAND,
						"collapse" => TrackingEvent.COLLAPSE,
						"acceptInvitationLinear" => TrackingEvent.ACCEPT_INVITATION_LINEAR,
						"closeLinear" => TrackingEvent.CLOSE_LINEAR,
						"skip" => TrackingEvent.SKIP,
						"progress" => TrackingEvent.PROGRESS];
}

enum TrackingEvent 
{
	/**
	 * not to be confused with an impression, this event indicates that an individual creative portion of the ad was viewed. An impression indicates the first frame of the ad was displayed; however an ad may be composed of multiple creative, or creative that only play on some platforms and not others. This event enables ad servers to track which ad creative are viewed, and therefore, which platforms are more common.
	 */
	CREATIVE_VIEW;
	/**
	 * this event is used to indicate that an individual creative within the ad was loaded and playback began. As with creativeView, this event is another way of tracking creative playback.
	 */
	START;
	/**
	 * the creative played for at least 25% of the total duration
	 */
	FIRST_QUARTILE;
	/**
	 * the creative played for at least 50% of the total duration
	 */
	MIDPOINT;
	/**
	 * the creative played for at least 75% of the duration
	 */
	THIRD_QUARTILE;
	/**
	 * The creative was played to the end at normal speed
	 */
	COMPLETE;
	/**
	 * the user activated the mute control and muted the creative
	 */
	MUTE;
	/**
	 * the user activated the mute control and unmuted the creative
	 */
	UNMUTE;
	/**
	 * the user clicked the pause control and stopped the creative
	 */
	PAUSE;
	/**
	 * the user activated the rewind control to access a previous point in the creative timeline
	 */
	REWIND;
	/**
	 * the user activated the resume control after the creative had been stopped or paused
	 */
	RESUME;
	/**
	 * the user activated a control to extend the video player to the edges of the viewer's screen
	 */
	FULLSCREEN;
	/**
	 * the user activated the control to reduce video player size to original dimensions
	 */
	EXIT_FULLSCREEN;
	/**
	 * the user activated a control to expand the creative
	 */
	EXPAND;
	/**
	 * the user activated a control to reduce the creative to its original dimensions
	 */
	COLLAPSE;
	/**
	 * the user activated a control that launched an additional portion of the creative. The name of this event distinguishes it from the existing “acceptInvitation” event described in the 2008 IAB Digital Video In-Stream Ad Metrics Definitions, which defines the "acceptInivitation" metric as applying to non-linear ads only. The “acceptInvitationLinear” event extends the metric for use in Linear creative
	 */
	ACCEPT_INVITATION_LINEAR;
	/**
	 * the user clicked the close button on the creative. The name of this event distinguishes it from the existing “close” event described in the 2008 IAB Digital Video In-Stream Ad Metrics Definitions, which defines the "close" metric as applying to non-linear ads only. The "closeLinear" event extends the "close" event for use in Linear creative
	 */
	CLOSE_LINEAR;
	/**
	 * the user activated a skip control to skip the creative, which is a different control than the one used to close the creative.
	 */
	SKIP;
	/**
	 * the creative played for a duration at normal speed that is equal to or greater than the value provided in an additional attribute for offset. Offset values can be time in the format HH:MM:SS or HH:MM:SS.mmm or a percentage value in the format n%. Multiple progress events with different values can be used to track multiple progress points in the Linear creative timeline
	 */
	PROGRESS;
}