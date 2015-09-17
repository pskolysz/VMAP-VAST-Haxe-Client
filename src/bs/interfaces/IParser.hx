package bs.interfaces;
import bs.model.vast.ad.Ad;
import bs.model.vast.Vast;
import haxe.Constraints.Function;
/**
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
interface IParser 
{
	function parse(xml:Xml):Vast;
}