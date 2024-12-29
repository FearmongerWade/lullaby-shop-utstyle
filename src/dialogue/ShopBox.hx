package dialogue;

class ShopBox extends FlxSpriteGroup
{
    public function new()
    {
        super();

        var white = new FlxSprite().makeGraphic(FlxG.width, 240, FlxColor.WHITE);
        add(white);
        white.y = FlxG.height-white.height;
        
        var black = new FlxSprite(white.x + 8, white.y + 8).makeGraphic(414, 225, FlxColor.BLACK);
        add(black);

        var blackc = new FlxSprite(428, black.y).makeGraphic(206, 225, FlxColor.BLACK);
        add(blackc);
    }
}