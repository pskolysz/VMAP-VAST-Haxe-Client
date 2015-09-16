package;
import bs.model.Ad;
import bs.tools.Trace;
import bs.vast.VASTClient;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Main
{
	

	public static function main() 
	{
		VASTClient.getVast("http://localhost/bigsoda/vmap/examples/vast/3.0.xml", onVastLoadSuccess, onVastLoadError);
		
	}
	
	static function onVastLoadSuccess(data:Xml):Void 
	{
		Trace.info("Vast Load Success");
		var ads:Array<Ad> = VASTClient.parseVast(data);
	}
	
	static function onVastLoadError(data:Dynamic):Void 
	{
		//Trace.error("Vast Load Error");
		//Trace.error(data);
	}
}