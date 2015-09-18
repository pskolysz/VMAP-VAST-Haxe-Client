package bs.model.vast.ad.creatives.linear;
import bs.model.vast.ad.creatives.MIMEType;



/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class MediaFile
{
	/**
	 * [Requierd] Url to media.
	 */
	public var url:String;
	/**
	 * an identifier for the media file
	 */
	public var id:String;
	/**
	 * [Requierd] either "progressive" for progressive download protocols (such as HTTP) or "streaming" for streaming protocols
	 */
	public var delivery:DeliveryType;
	/**
	 * [Requierd] MIME type for the file container. Popular MIME types include, but are not limited to "video/xflv" for Flash Video and “video/mp4” for MP4
	 */
	public var type:MIMEType;
	/**
	 * for progressive load video, the bitrate value specifies the average bitrate for the media file; otherwise the minBitrate and maxBitrate can be used together to specify the minimum and maximum bitrates for streaming videos
	 */
	public var bitrate:Float;
	/**
	 * for progressive load video, the bitrate value specifies the average bitrate for the media file; otherwise the minBitrate and maxBitrate can be used together to specify the minimum and maximum bitrates for streaming videos
	 */
	public var minBitrate:Float;
	/**
	 * for progressive load video, the bitrate value specifies the average bitrate for the media file; otherwise the minBitrate and maxBitrate can be used together to specify the minimum and maximum bitrates for streaming videos
	 */
	public var maxBitrate:Float;
	/**
	 * [Requierd] the native width of the video file, in pixels
	 */
	public var width:Float;
	/**
	 * [Requierd] the native height of the video file, in pixels
	 */
	public var height:Float;
	/**
	 * identifies whether the media file is meant to scale to larger dimensions
	 */
	public var scalable:String;
	/**
	 * a Boolean value that indicates whether aspect ratio for media file dimensions should be maintained when scaled to new dimensions
	 */
	public var mantainAspectRatio:Bool;
	/**
	 * the codec used to encode the file which can take values as specified by RFC 4281
	 */
	public var codec:String;
	/**
	 * identifies the API needed to execute an interactive media file
	 */
	public var apiFreamwork:String;
	
	public function new() 
	{
		
	}
	
}

@:enum
abstract DeliveryType(String) 
{
	var PROGRESSIVE = "progressive";
	var STREAMING = "streaming";
}