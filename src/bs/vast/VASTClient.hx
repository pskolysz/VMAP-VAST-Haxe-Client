package bs.vast;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.HttpError;
import bs.model.vast.Vast;
import bs.parser.VAST_1_0;
import bs.parser.VAST_2_0;
import bs.parser.VAST_3_0;
import bs.tools.Trace;
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
	
	public static function parseVast(xml:Xml, success:Vast->Void, error:Dynamic->Void):Void
	{ 
		var version = Vast.getVersion(new Fast(xml).node.VAST.att.version);
		var parser:Class<IParser>;
		switch(version) {
			case VastVersion.v_2_0 | VastVersion.v_2_0 | VastVersion.v_3_0 : parser = VAST_3_0; 
			default : parser = VAST_3_0;
		}
		VastParser.parse(xml, parser, success, error);
	}
	
	public static function getVast(url:String, success:Dynamic->Void, error:Dynamic->Void, ?timeout = 6000):Void
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