package substates;

class TransIn extends flixel.FlxSubState
{
    public function new()
    {
        super();

        var black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        black.scrollFactor.set();
        add(black);
        FlxTween.tween(black, {alpha:0}, 0.3, {ease:FlxEase.quadInOut, onComplete: function(twn:FlxTween) {
            black.kill();
            close();
        }});
    }
}