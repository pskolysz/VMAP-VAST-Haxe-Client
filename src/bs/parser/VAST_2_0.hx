package bs.parser;
import bs.interfaces.IParser;
import bs.tools.Trace;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VAST_2_0 implements IParser
{

	public function new() 
	{
		
	}
	
	public function parse(xml:Xml):Void
	{
		trace("PARSE FROM VAST_2_0 Parser");
	}
	
}