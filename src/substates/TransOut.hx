package substates;

import states.ShopState;

class TransOut extends flixel.FlxSubState
{
    public function new()
    {
        super();

        var black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        black.scrollFactor.set();
        black.alpha = 0;
        add(black);
        FlxTween.tween(black, {alpha:1}, 0.3, {ease:FlxEase.quadInOut, onComplete: function(twn:FlxTween) {
            FlxG.switchState(new ShopState());
        }});
    }
}