package backend;

class Utils
{
    public static function saveGameTime()
    {
        Settings.data.gameTime += Math.floor(FlxG.game.ticks / 1000);

        Settings.save();
    }

    @:access(flixel.util.FlxSave.validate)
    inline public static function getSavePath()
    {
        var company = FlxG.stage.application.meta.get('company');
        var file = FlxG.stage.application.meta.get('file');

        return company + '/' + flixel.util.FlxSave.validate(file);
    }
}