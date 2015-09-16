package bs.model;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class HttpError
{
	public static var CODE_403:Dynamic = { code:403, title:"Forbidden", description:"The request was a valid request, but the server is refusing to respond to it. Unlike a 401 Unauthorized response, authenticating will make no difference." };
	public static var CODE_404:Dynamic = { code:404, title:"Not Found", description:"The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible." };
	public static var CODE_503:Dynamic = { code:503, title:"Service Unavailable" ,description:"The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state." };
	
	public static var LIST:Array<Dynamic> = [CODE_403, CODE_404, CODE_503];
	public function new() 
	{
		
	}
	
}