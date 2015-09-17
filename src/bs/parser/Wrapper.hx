package bs.parser;
import bs.model.HttpError;
import bs.model.VastError;
import bs.tools.Trace;
import haxe.Constraints.Function;
import haxe.xml.Fast;
import js.html.XMLDocument;
import js.html.XMLHttpRequest;
import js.html.XMLSerializer;
/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Wrapper
{
	//TODO marge campanions in creatives
	
	/**
	 * Maximum number of chain wrapper.
	 */
	public static var maxWrapperChain = 5;
	
	static var currentWrapperChain:Map<String,Int> = new Map<String,Int>();
	static var orginalVast:Xml;
	static var success:Xml->Void;
	static var error:Dynamic->Void;
	static var warn:Dynamic->Void;
	
	//public static var requestFactory:Dynamic;
	
	public function new() 
	{
		
	}
	/**
	 * Check if there are any tag wrappers in vast.
	 * @param vast VAST Xml with or without wrappers
	 * @return VAST Xml without wrappers
	 */
	public static function check(vast:Xml, onSuccess:Xml->Void, onError:Dynamic->Void, onWarn:Dynamic->Void):Void 
	{
		orginalVast = vast;
		success = onSuccess;
		error = onError;
		warn = onWarn;
		checkForWrappers(vast);
	}
	
	
	static function checkForWrappers(xml:Xml):Void
	{
		var isWrapper:Bool = false;
		
		for (ad in xml.firstElement().elementsNamed("Ad")) {
			if (ad.firstElement().nodeName == "Wrapper") {
				isWrapper = true;
				if (wrapperGetMaxChain(ad)) {
					warn(VastError.CODE_302);
					continue;
				}
				
				loadXML(ad.firstElement().elementsNamed("VASTAdTagURI").next().firstChild().nodeValue);
				break;
			}
		}
		if (!isWrapper) success(orginalVast);
	}
	
	static private function wrapperGetMaxChain(ad:Xml):Bool
	{
		if(!ad.exists("bs-uid"))
			generateAdUid(ad);
		
		if (!currentWrapperChain.exists(ad.get("bs-uid")))
			currentWrapperChain.set(ad.get("bs-uid"), 1);
		else 
			currentWrapperChain.set(ad.get("bs-uid"), currentWrapperChain.get(ad.get("bs-uid")) + 1);
		
		return currentWrapperChain.get(ad.get("bs-uid")) == (maxWrapperChain+1);
	}
	
	static private function generateAdUid(ad:Xml) 
	{
		var chars =  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		var uid = "";
		
		for (i in 0...50) {
			uid += chars.charAt(Math.floor(Math.random() * (chars.length - 1)));
		}
		
		uid += "."+ Date.now().getTime();
		ad.set("bs-uid", uid);
	}
	
	static function loadXML(url:String):Void
	{
		var req:XMLHttpRequest = new XMLHttpRequest();
		req.onerror = function():Void {
			Trace.info("error: " + req.status);
		}
		
		req.onloadend = function():Void	{
			if (req.status == 200) 
				mergeVast(Xml.parse(req.response));
			else {
				mergeVast(Xml.parse("<VAST/>"));
				Trace.info("loadXML - 2");
			}
		}; 
		req.open('GET', url);
		req.send();
	}
	
	static private function mergeVast(wrapper:Xml):Void
	{
		var orginalWrapper = Xml.parse("");
		var fastWrapper = new Fast(wrapper);
		Trace.log("mergeVast");
		Trace.xmlFromString(wrapper.toString());
		
		if (!fastWrapper.hasNode.VAST ||
			!fastWrapper.node.VAST.hasNode.Ad ||
			(!fastWrapper.node.VAST.node.Ad.hasNode.Wrapper && 
			!fastWrapper.node.VAST.node.Ad.hasNode.InLine)) {
			removeWrapperTag(orginalVast);
			checkForWrappers(orginalVast);
			warn(VastError.CODE_303);
			Trace.log("mergeVast - IF");
			return;
		}
		
		for (ad in orginalVast.firstElement().elementsNamed("Ad")) {
			if (ad.firstElement().nodeName == "Wrapper") {
				orginalWrapper = ad.firstElement();
				//removed orginal wrapper
				ad.removeChild(orginalWrapper);
				//add loaded wraper in place on removed wrapper
				ad.addChild(wrapper.firstElement().firstElement().firstElement());
				//add removed wrapper taggs to new wprapper
				addOldTags(ad, orginalWrapper);
				break;
			}
		}
		
		checkForWrappers(orginalVast);
	}
	
	static private function removeWrapperTag(xml:Xml):Void 
	{
		var orginalAd = Xml.parse("");
		for (ad in orginalVast.firstElement().elementsNamed("Ad")) {
			if (ad.firstElement().nodeName == "Wrapper") {
				orginalAd = Xml.parse(ad.toString());
				ad.removeChild(ad.firstElement());
				var inLine = Xml.createElement("InLine");
				ad.addChild(inLine);
				for (element in orginalAd.firstElement().firstElement().elements()) {	
					if (element.nodeName == "VASTAdTagURI") continue;
					ad.firstElement().addChild(element);
				}
				break;
			}
		}
	}
	
	static private function addOldTags(ad:Xml, orginalWrapper:Xml):Void 
	{
		
		var fastAd:Fast = new Fast(ad);
		var fastWrapper:Fast = new Fast(orginalWrapper);
		
		adImpression(ad, orginalWrapper);
		addError(ad, orginalWrapper);
		addCreatives(ad, orginalWrapper);
		//Extensions
	}
	
	static private function adImpression(ad:Xml, wrapper:Xml) 
	{
		for (impression in wrapper.elementsNamed("Impression")) {
			ad.firstElement().addChild(impression);
		}
	}
	
	static private function addError(ad:Xml, wrapper:Xml) 
	{
		for (error in wrapper.elementsNamed("Error")) {
			ad.firstElement().addChild(error);
		}
	}
	
	static private function addCreatives(ad:Xml, wrapper:Xml) 
	{
		var adHasCreatives = ad.firstElement().elementsNamed("Creatives").hasNext();
		var wrapperHasCreatives = wrapper.elementsNamed("Creatives").hasNext();
		//Trace.logColor("adHasCreatives: " + adHasCreatives +", wrapperHasCreatives: " + wrapperHasCreatives);
		
		
		if (!adHasCreatives && wrapperHasCreatives) {
			ad.firstElement().addChild(wrapper.elementsNamed("Creatives").next());
		}
		
		
		
		if (adHasCreatives && wrapperHasCreatives) {
			for (creative in wrapper.elementsNamed("Creatives").next().elementsNamed("Creative")) {
				//Linear Tracking
				Trace.xmlFromString(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().toString());
				
				for (tracking in creative.elementsNamed("Linear").next().elementsNamed("TrackingEvents").next().elementsNamed("Tracking")) {
					//TODO Ad doesn't have Tracking event
					var f:Fast = new Fast(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next());
					Trace.logColor("fast: " + f.hasNode.TrackingEvents);
					Trace.logColor(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("TrackingEvents").hasNext());
					
					if(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("TrackingEvents").hasNext()) {
						ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("TrackingEvents").next().addChild(tracking);
					} else {
						Trace.logColor("ADD TRACKING EVENTS");
						ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().addChild(Xml.parse("<TrackingEvents></TrackingEvents>"));
						
						//ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("TrackingEvents").next().addChild(tracking);
					}
					
				}
				Trace.xmlFromString(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().toString());
				
				//Linear Video clicks
				//for (videoClick in creative.elementsNamed("Linear").next().elementsNamed("VideoClicks").next().elements())	{
					//ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("VideoClicks").next().addChild(videoClick);
				//}
				
			}
		}
	}
	
	/*static function newXMLHttpRequest(): XMLHttpRequest
	{
		if (requestFactory) {
			return Type.createInstance(requestFactory, []);
		}
		return new XMLHttpRequest();
	}*/
}