package backend;

class Utils
{
    public static function saveGameTime()
    {
        Settings.data.gameTime += Math.floor(FlxG.game.ticks / 1000);

        Settings.save();
    }
}