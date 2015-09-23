package bs.model.vast.ad.creatives;
import haxe.ds.StringMap;

/**
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class  MIMETypeTool
{
	static var enumMap = ["video/x-flv" => MIMEType.VIDEO_X_FLV,
						"video/mp4" => MIMEType.VIDEO_MP4,
						"video/f4v" => MIMEType.VIDEO_F4V,
						"video/f4m" => MIMEType.VIDEO_F4M,
						"application/x-shockwave-flash" => MIMEType.APPLICATION_X_SHOCKWAVE_FLASH,
						"application/x-javascript" => MIMEType.APPLICATION_X_JAVASCRIPT,
						"image/jpeg" => MIMEType.IMAGE_JPEG,
						"image/gif" => MIMEType.IMAGE_GIF,
						"image/png" => MIMEType.IMAGE_PNG];
	
	private function new(type) 
	{
		
	}
	
	public static inline function getType(type:String):MIMEType
	{
		if (!enumMap.exists(type))
			return MIMEType.NOT_SUPPORTED;
			
		return enumMap.get(type);
	}
}

enum MIMEType
{
	VIDEO_X_FLV;
	VIDEO_MP4;
	VIDEO_F4V;
	VIDEO_F4M;
	APPLICATION_X_SHOCKWAVE_FLASH;
	APPLICATION_X_JAVASCRIPT;
	IMAGE_JPEG;
	IMAGE_GIF;
	IMAGE_PNG;
	NOT_SUPPORTED;
}