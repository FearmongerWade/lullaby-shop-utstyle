package backend;

import flixel.util.FlxSave;

@:structInit class SaveData
{
	public var gameTime:Int = 0;

    public var gold:Float = 400;
    public var curSpace:Int = 0;
    public var maxSpace:Int = 8;
}

class Settings
{
	public static var defaultData:SaveData = {};
	public static var data:SaveData = defaultData;

    public static function save()
	{
		for (key in Reflect.fields(data))
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));

		FlxG.save.flush();
	}

	public static function load()
	{
		FlxG.save.bind('settings', Utils.getSavePath());

		for (key in Reflect.fields(data))
			if (Reflect.hasField(FlxG.save.data, key))
				Reflect.setField(data, key, Reflect.field(FlxG.save.data, key));			
	}
}