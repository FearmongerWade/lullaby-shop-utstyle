package states;

class FakeState extends FlxState
{
    override function create()
    {
        if (FlxG.sound.music.playing)
            FlxG.sound.music.stop();

        FlxG.sound.playMusic(Paths.music('ruins'));

        var gameplay = new FlxSprite().loadGraphic(Paths.image('very convincing gameplay'));
        add(gameplay);

        var text = new FlxText(0, 0, 0, 'very convincing gameplay i know', 20);
        text.screenCenter(X);
        text.alignment = CENTER;
        text.font = Paths.font();
        add(text);
        text.y = FlxG.height - text.height;
        text.alpha = 0.2;

        super.create();
    }

    var fuck:Bool = false;
    override function update(elapsed:Float)
    {
        if (!fuck)
        {
            if (Controls.justPressed('movement'))
            {
                fuck = true;
                openSubState(new substates.EnterBattle());
            }
        }
        
        super.update(elapsed);
    }
}