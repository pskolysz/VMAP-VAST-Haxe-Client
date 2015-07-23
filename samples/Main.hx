package;
import bs.model.Ad;
import bs.vast.VASTClient;

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
		var ads:Array<Ad> = VASTClient.parseVast(data);
	}
	
	static function onVastError(data:Dynamic):Void 
	{
		trace(data);
	}
}