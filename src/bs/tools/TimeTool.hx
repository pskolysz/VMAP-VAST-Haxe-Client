package bs.tools;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class TimeTool
{

	public function new() 
	{
		
	}
	
	public static inline function convertOffsetToSeconds(offset:String, duration:Float):Float
	{
		var result = 0.000;
		if (offset.indexOf("%") > -1) {
			var percent = Std.parseInt(offset.split("%")[0]);
			result =  duration * (percent / 100);
			 return result;
		}
		result = convertTimeToSeconds(offset);
		return result;
	}
	
	public static inline function convertTimeToSeconds(value:String):Float
	{
		var result = 0.000;
		var miliseconds = 0.0;
		var duration = value.split(".");
		var time = duration[0].split(":");
		result += Std.parseFloat(time[2]);
		result += Std.parseFloat(time[1]) * 60;
		result += Std.parseFloat(time[0]) * 60 * 60;
		if (duration.length > 1) miliseconds = Std.parseFloat("0."+duration[1]);
		result += miliseconds;
		return result;
	}
	
	
	public static inline function convertTimeToText(value:Float, ?showMiliseconds = false):String
	{
		if (value < 0 ) return "";
		
		var s = value-Std.int(value)+"";
		var miliseconds = s.substr(2, 3);
		var seconds = Std.int(value % 60);
		var minutes = Std.int((value / 60) % 60);
		var hours = Std.int((value / 3600) % 24);
		var h = (hours < 10)?("0" + hours):hours+"";
		var m = (minutes < 10)?("0" + minutes):minutes+"";
		var s = (seconds < 10)?("0" + seconds):seconds+"";
		
		
		var result = h+":"+m+":"+s;
		if (showMiliseconds) result += "." + miliseconds;
		trace(result);
		return result;
	}
	
	
}