package bs.vast;
import js.html.XMLHttpRequest;
/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VastParser
{
	static var orginalVast:Xml;
	public function new() 
	{
		
	}
	
	public static function parse(data:Xml, parser:Class<Dynamic>):Void 
	{
		
		orginalVast = data;
		checkForWrappers(data);
		//var parser = Type.createInstance(parser, []);
		//parser.parse(data);
		
	}
	
	
	static function checkForWrappers(xml:Xml):Void
	{
		for (ad in xml.firstElement().elementsNamed("Ad")) 
		{
			if (ad.firstElement().nodeName == "Wrapper") {
				loadXML(ad.firstElement().elementsNamed("VASTAdTagURI").next().firstChild().nodeValue);
				break;
			}
		}
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
					if (ad.firstElement().nodeName == "Wrapper") {
						mergeVast(xml);
						break;
					}
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
	
	static private function mergeVast(wrapper:Xml):Void
	{
		//TODO wrapper can be empty
		//TODO wrapper can not have a Ad tag
		//TODO behavior for more that one wrapper in orginal XML
		
		
		//Wrapper exists and has tags
		var orginalWrapper = Xml.parse("");
		for (ad in orginalVast.firstElement().elementsNamed("Ad")) 
		{
			if (ad.firstElement().nodeName == "Wrapper") {
				orginalWrapper = ad.firstElement();
				ad.removeChild(orginalWrapper);
				ad.addChild(wrapper.firstElement().firstElement().firstElement());
				addOldTags(ad, orginalWrapper);
				break;
			}
		}
		trace(orginalVast.toString());
		checkForWrappers(orginalVast);
	}
	
	static private function addOldTags(ad:Xml, orginalWrapper:Xml) 
	{
		//Impressions
		for (impression in orginalWrapper.elementsNamed("Impression")) 
		{
			ad.firstElement().addChild(impression);
		}
	}
}