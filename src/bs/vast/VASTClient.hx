package bs.vast;
import bs.model.Ad;
import bs.model.HttpError;
import bs.parser.VAST_2_0;
import bs.parser.VAST_3_0;
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
	
	public static function parseVast(xml:Xml):Array<Ad>
	{ 
		
		VastParser.parse(xml, VAST_2_0);
		return new Array<Ad>();
	}
	
	public static function getVast(url:String, success:Function, error:Function, ?timeout = 6000):Void
	{
		var req:XMLHttpRequest = new XMLHttpRequest();
		req.onerror = error;
		
		req.onloadend = function():Void 
		{
			if (req.status == 200) 
			{			
				var xml = Xml.parse(req.response); 
				success(xml);
			} else {
				for (err in HttpError.LIST) 
				{
					if (err.code == req.status)
						error(err);
					else 
						error({code:req.status , title:"", description:req.statusText });
				}
			}
			
		}; 
		req.open('GET', url);
		req.timeout = timeout;
		req.send();
	}
	
}