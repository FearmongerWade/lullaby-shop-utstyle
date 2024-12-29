package dialogue;

import flixel.addons.text.FlxTypeText;

class DialogueBox extends FlxSpriteGroup
{
    var dialogue:FlxTypeText;

    public function new(text:String, ?name:String)
    {
        super();

        var white = new FlxSprite(0, 320).makeGraphic(575, 150, FlxColor.WHITE);
        white.screenCenter(X);
        add(white);

        var black = new FlxSprite(white.x+5, white.y+5).makeGraphic(565, 140, FlxColor.BLACK);
        add(black);

        var stupid = new FlxText(black.x+10, black.y+10, 0, '*', 30);
        stupid.font = Paths.font('PixelOperator-Bold.ttf');
        add(stupid);

        dialogue = new FlxTypeText(stupid.x + stupid.width + 20, stupid.y, Std.int(white.width * 0.7), text, 30);
        dialogue.font = Paths.font('PixelOperator-Bold.ttf');
        dialogue.sounds = [FlxG.sound.load(Paths.sound('text_snd_default'))];
        add(dialogue);

        startDialogue(text);
    }

    public function startDialogue(text:String)
    {
        dialogue.resetText(text);
        dialogue.start(0.04, true);
    }
}