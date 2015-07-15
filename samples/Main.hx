package;
import bs.model.Ad;
import bs.vast.VASTClient;
import js.html.ProgressEvent;
import js.html.XMLHttpRequest;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Main
{
	

	public static function main() 
	{
		VASTClient.getVast("http://localhost/bigsoda/vmap/examples/vast/2.0.xml", onVastLoadSucces, onVastError);
	}
	
	static function onVastLoadSucces(data:Xml):Void 
	{
		//TODO change to array
		var ad:Ad = VASTClient.parseVast(data);
	}
	
	static function onVastError(data:Dynamic):Void 
	{
		trace(data);
	}
}