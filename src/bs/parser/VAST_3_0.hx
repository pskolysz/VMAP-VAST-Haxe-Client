package bs.parser;
import bs.interfaces.IParser;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VAST_3_0 implements IParser
{

	public function new() 
	{
		
	}
	
	public function parse(vast:Xml):Void 
	{
		trace("PARSE FROM VAST_3_0 Parser");
	}
	
}