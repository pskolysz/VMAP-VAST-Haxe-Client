package bs.vast;
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
	
	public static function checkForWrappers(xml:Xml, onComplete:Function):Void
	{
		for (ad in xml.firstElement().elementsNamed("Ad")) 
		{
			if (ad.firstElement().nodeName == "Wrapper")
				loadXML(ad.firstElement().elementsNamed("VASTAdTagURI").next().firstChild().nodeValue);
		}
	}
	
	public static function parseVast(xml:Xml):Void
	{
		
	}
	
	public static function getVast(url:String, success:Function, error:Function):Void
	{
		var req:XMLHttpRequest = new XMLHttpRequest();
		req.onerror = error;
		req.timeout = 6000;
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
	
	static function loadXML(url:String):Void
	{
		var req:XMLHttpRequest = new XMLHttpRequest();
		req.onloadend = function():Void 
		{
			if (req.status == 200) 
			{
				var xml = Xml.parse(req.response); 
				for (ad in xml.firstElement().elementsNamed("Ad")) 
				{
					if (ad.firstElement().nodeName == "Wrapper")
						loadXML(ad.firstElement().elementsNamed("VASTAdTagURI").next().firstChild().nodeValue);
				}
			} else if (req.status >= 400) {
				//TODO error handler
			} else {
				//TODO error handler
			}
		}; 
		req.open('GET', url);
		req.send();
	}
	
}