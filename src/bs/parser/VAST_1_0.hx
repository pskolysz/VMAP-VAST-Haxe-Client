package bs.parser;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.vast.Vast;
import bs.tools.Trace;
import haxe.Constraints.Function;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VAST_1_0 implements IParser
{

	public function new() 
	{
		
	}
	
	public function parse(xml:Xml):Vast 
	{
		trace("PARSE FROM VAST_2_0 Parser");
		return new Vast();
	}
	
}