package bs.model.vast.ad.creatives;

/**
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class  MIMETypeTool
{
	private function new(type) 
	{
		
	}
	public static inline function getType(type:String):MIMEType
	{
		switch(type) 
		{
			case "video/x-flv":
				return MIMEType.VIDEO_X_FLV;
			case "video/mp4":
				return MIMEType.VIDEO_MP4;
			case "video/f4v":
				return MIMEType.VIDEO_F4V;
			case "video/f4m":
				return MIMEType.VIDEO_F4M;
			case "application/x-shockwave-flash":
				return MIMEType.APPLICATION_X_SHOCKWAVE_FLASH;
			case "application/x-javascript":
				return MIMEType.APPLICATION_X_JAVASCRIPT;
			case "image/jpeg":
				return MIMEType.IMAGE_JPEG;
			case "image/gif":
				return MIMEType.IMAGE_GIF;
			case "image/png":
				return MIMEType.IMAGE_PNG;
			default:
				return MIMEType.NOT_SUPPORTED;
		}
	}
}

@:enum 
abstract MIMEType(String)
{
	var VIDEO_X_FLV = "video/x-flv";
	var VIDEO_MP4 = "video/mp4";
	var VIDEO_F4V = "video/f4v";
	var VIDEO_F4M = "video/f4m";
	var APPLICATION_X_SHOCKWAVE_FLASH = "application/x-shockwave-flash";
	var APPLICATION_X_JAVASCRIPT = "application/x-javascript";
	var IMAGE_JPEG = "image/jpeg";
	var IMAGE_GIF = "image/gif";
	var IMAGE_PNG = "image/png";
	var NOT_SUPPORTED = "Not Supported MIMEType";
}