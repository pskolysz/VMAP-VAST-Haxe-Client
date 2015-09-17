package bs.parser;
import bs.interfaces.IParser;
import bs.model.Ad;
import haxe.Constraints.Function;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VAST_3_0 implements IParser
{

	public function new() 
	{
		
	}
	
	public function parse(vast:Xml):Array<Ad> 
	{
		trace("PARSE FROM VAST_3_0 Parser");
		return new Array<Ad>();
	}
	
}