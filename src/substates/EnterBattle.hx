package substates;

import states.PlayState;
import flixel.effects.FlxFlicker;

class EnterBattle extends flixel.FlxSubState
{
    public function new() 
    {
        super();

        if (FlxG.sound.music.playing)
            FlxG.sound.music.stop();

        var black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        black.alpha = 0.0001;
        add(black);

        var soul = new FlxSprite(400, 250).loadGraphic(Paths.image('soul'));
        soul.visible = false;
        add(soul);

        var bubble = new FlxSprite(400, 190).loadGraphic(Paths.image('ex_bubble'));
        bubble.scale.set(3,3);
        add(bubble);
        
        FlxG.sound.play(Paths.sound('battle/encounter'));

        new FlxTimer().start(1, function(tmr:FlxTimer) {
            black.alpha = 1;
            bubble.alpha = 0;
            FlxG.sound.play(Paths.sound('battle/flicker'));
            FlxFlicker.flicker(soul, 0.2, 0.05, true, false);
        });
        new FlxTimer().start(1.15, function(tmr:FlxTimer)
        {
            FlxG.sound.play(Paths.sound('battle/flicker'));
        });
        new FlxTimer().start(1.25, function(tmr:FlxTimer) {
            FlxG.sound.play(Paths.sound('battle/fack'));
            FlxTween.tween(soul, {x: 40, y:FlxG.height - soul.height - 30, alpha: 0}, 0.4, 
                {/*ease:FlxEase.quartInOut,*/
                onComplete: function(twn:FlxTween) {
                    new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        FlxG.switchState(new PlayState());
                    });
                }});
        });
    }
}