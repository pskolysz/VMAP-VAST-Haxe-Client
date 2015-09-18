package bs.model.vast.ad.creatives;

/**
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
@:enum 
abstract MIMEType(String)
{
	var VIDEO_X-FLV = "video/x-flv";
	var VIDEO_MP4 = "video/mp4";
	var VIDEO_F4V = "video/f4v";
	var VIDEO_F4M = "video/f4m";
	var APPLICATION_X-SHOCKWAVE-FLASH = "application/x-shockwave-flash";
	var APPLICATION_X-JAVASCRIPT = "application/x-javascript";
	var IMAGE_JPEG = "image/jpeg";
	var IMAGE_GIF = "image/gif";
	var IMAGE_PNG = "image/png";
}