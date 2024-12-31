package states;

import dialogue.ShopBox;
import flixel.addons.text.FlxTypeText;

class ShopState extends FlxState
{
    /*
    shit to add:
    - silver cartridge      - 0G      - Free of charge. 
    - game boy advance sp   - 300G    - Stupid thing does nothing but make annoying sounds.
    - mysterious letter     - 666G    - The envelope has your name on it.
    - broken vinyl          - 250G    - I don't want this, but it's funny to make you pay for it.

    sell line:
    - Why would I buy your shit back? I'm trying to get rid of it, you moron.

    clicking talk:
    - Your nose is weird.
    - Don't worry. I've got an eternity. Can you say the same?
    - Don't sympathize with evil.
    - Speaking ill of another man's hat is dishonorable.
    - I'll have you know I don't appreciate window shoppers.
    
    not enough money line:
    - You're joking, right?
    */
    var soul:FlxSprite; // selector

    var curSelected:Int = 0;
    var options:Array<String> = ['Buy', 'Sell', 'Talk', 'Exit'];
    var grpText:FlxTypedGroup<FlxText>;

    var dialogue:FlxTypeText;

    var goldText:FlxText;
    var itemsText:FlxText;

    override function create()
    {
        // yeah

        FlxG.mouse.visible = false;
        FlxG.sound.playMusic(Paths.music('shopMenu'));
        openSubState(new substates.TransIn());

        // background assets

        var bg = new FlxSprite().loadGraphic(Paths.image('bg'));
        add(bg);

        var guy = new FlxSprite(180, 22).loadGraphic(Paths.image('cartridge_guy'), true, 237, 222);
        guy.animation.add('idle', [0,1], 2, true);
        guy.animation.play('idle');
        add(guy);

        var candle = new FlxSprite(123, 120).loadGraphic(Paths.image('candle'), true, 106, 126);
        candle.animation.add('flame', [0,1], 2, true);
        candle.animation.play('flame');
        add(candle);

        var sign = new FlxSprite(170).loadGraphic(Paths.image('sign'));
        add(sign);
        
        // options waa

        var dumb = new ShopBox();
        add(dumb);

        dialogue = new FlxTypeText(40, 268, 380, null, 30);
        dialogue.font = Paths.font();
        dialogue.sounds = [FlxG.sound.load(Paths.sound('textbox/cartridgeGuy'))];
        add(dialogue);

        soul = new FlxSprite().loadGraphic(Paths.image('soul'));
        add(soul);

        grpText = new FlxTypedGroup<FlxText>();
        add(grpText);

        for (i in 0...options.length)
        {
            var item = new FlxText(480, 268 + (i*35), 0, options[i], 32);
            item.font = Paths.font();
            item.ID = i;
            grpText.add(item);
        }

        goldText = new FlxText(460, 428, 0, Settings.data.gold+'G', 30);
        goldText.font = Paths.font();
        add(goldText);

        itemsText = new FlxText(560, 428, 0, Settings.data.curSpace+'/'+Settings.data.maxSpace, 30);
        itemsText.font = Paths.font();
        add(itemsText);

        changeItem();
        updateText();
        super.create();
    }

    override function update(elapsed:Float)
    {
        if (Controls.justPressed('menuUp'))
            changeItem(-1);
        if (Controls.justPressed('menuDown'))
            changeItem(1);

        super.update(elapsed);
    }

    function changeItem(change:Int = 0)
    {
        curSelected = FlxMath.wrap(curSelected + change, 0, options.length-1);

        grpText.forEach(function(txt:FlxText)
        {
            if (txt.ID == curSelected)
            {
                soul.x = txt.x - 30;
                soul.y = txt.y + 10;
            }    
        });

        FlxG.sound.play(Paths.sound('moveMenu'));
    }

    function updateText(text:String = "* Don't sympathize with evil.")
    {
        dialogue.resetText(text);
        dialogue.start(0.04, true);
    }
}