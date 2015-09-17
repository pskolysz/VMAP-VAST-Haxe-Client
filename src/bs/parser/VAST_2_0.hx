package bs.parser;
import bs.interfaces.IParser;
import bs.model.Ad;
import bs.tools.Trace;
import haxe.Constraints.Function;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VAST_2_0 implements IParser
{

	public function new() 
	{
		
	}
	
	public function parse(xml:Xml):Array<Ad> 
	{
		trace("PARSE FROM VAST_2_0 Parser");
		return new Array<Ad>();
	}
	
}