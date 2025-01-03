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
class OtherBox extends FlxSpriteGroup
{
    var descText:FlxText;

    public function new(text:String = 'item description')
    {
        super();

        var white = new FlxSprite(423).makeGraphic(225, 225, FlxColor.WHITE);
        add(white);

        var black = new FlxSprite(white.x+5, white.y+8).makeGraphic(206, 225, FlxColor.BLACK);
        add(black);

        descText = new FlxText(black.x + 8, black.y + 5, black.width*0.9, text, 28);
        descText.font = Paths.font();
        add(descText);

        updateItemText();
    }

    public function updateItemText(text:String = 'new item desc')
    {
        descText.text = text;
    }
}