package bs.model.vast.ad.creatives;

/**
 * When an API framework is needed to execute creative, a <CreativeExtensions> element can be added under the <Creative>. This extension can be used to load an executable creative with or without!using a!media!file.
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class CreativeExtension
{
	public var type:MIMEType;
	public var data:String;
	public function new() 
	{
		
	}
	
}