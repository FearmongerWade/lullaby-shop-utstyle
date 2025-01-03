package states;

class EndState extends FlxState
{
    var text:FlxText;

    override function create()
    {
        FlxG.sound.music.stop();

        text = new FlxText(0, 0, FlxG.width, '', 35);
        text.font = Paths.font();
        text.alignment = CENTER;
        text.screenCenter(X);
        add(text);

        super.create();

        changeText('UNDERTALE\n\nBy Toby Fox and Temmie Chang', 180);
        new FlxTimer().start(5, function(tmr:FlxTimer) {
            changeText('Art and Programming\n_feamonger\n\nLullaby Shop Theme\nSaster\n\nCartridge Guy\nBanbuds & ImKeeby', 100);
            new FlxTimer().start(5, function(tmr:FlxTimer){
                changeText('Created from ground up with\nHaxeFlixel', 180);
                new FlxTimer().start(5, function(tmr:FlxTimer) {
                    changeText('Thanks for watching', 220, 50);
                });
            });
        });
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }

    function changeText(newText:String, ?yPos:Float = 80, ?newSize:Int = 35)
    {
        FlxG.sound.play(Paths.sound('impact'));
        text.text = newText;
        text.size = newSize;
        text.y = yPos;
    }
}