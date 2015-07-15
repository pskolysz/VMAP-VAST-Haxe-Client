package bs.vast;
import bs.model.Ad;
import bs.parser.VAST_2_0;
import haxe.Constraints.Function;
import haxe.Http;
import haxe.xml.Fast;
import js.html.ProgressEvent;
import js.html.XMLHttpRequest;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VASTClient
{
	public function new() 
	{
		
	}
	
	public static function parseVast(xml:Xml):Ad
	{
		VastParser.parse(xml, VAST_2_0);
		return new Ad();
	}
	
	public static function getVast(url:String, success:Function, error:Function, ?timeout = 6000):Void
	{
		var req:XMLHttpRequest = new XMLHttpRequest();
		req.onerror = error;
		req.timeout = timeout;
		req.onloadend = function():Void 
		{
			if (req.status == 200) 
			{			
				var xml = Xml.parse(req.response); 
				success(xml);
			} else if (req.status >= 400) {
				error({"status":req.status, "statusText":req.statusText, "timeout":req.timeout});
			} else {
				error( { "status":req.status, "statusText":req.statusText } );
				
			}
			
		}; 
		req.open('GET', url);
		req.send();
		
	}
}