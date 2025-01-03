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