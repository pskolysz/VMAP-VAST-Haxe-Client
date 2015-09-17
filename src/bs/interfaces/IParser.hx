package bs.interfaces;
import bs.model.Ad;
import haxe.Constraints.Function;
/**
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
interface IParser 
{
	function parse(xml:Xml):Array<Ad>;
}