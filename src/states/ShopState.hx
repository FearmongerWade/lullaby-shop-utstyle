package states;

import dialogue.ShopBox;
import dialogue.ShopBox.OtherBox;
import flixel.addons.text.FlxTypeText;

class ShopState extends FlxState
{
    var soul:FlxSprite; // selector

    var curSelected:Int = 0;
    var options:Array<String> = ['Buy', 'Sell', 'Talk', 'Exit'];
    var grpText:FlxTypedGroup<FlxText>;

    var prefix:FlxText;
    var dialogue:FlxTypeText;

    var goldText:FlxText;
    var itemsText:FlxText;

    var curItem:Int = 0;
    var itemBox:OtherBox;
    var otherDialogue:FlxTypeText;
    var shopItems:Array<Array<Dynamic>> = [
        // variable - item name - price - dialogue line
        ['Silver Cartridge',         0,   'Free of charge.'],
        ['Game Boy Advance SP',      300, 'Stupid thing does nothing but make annoying sounds.'],
        ['Mysterious Letter',        666, 'The envelope has your name on it.'],
        ['Broken Vinyl',             500, "I don't want this, but it's funny to make you pay for it."],
        ['Exit',                     0,   'Going so soon?']
    ];
    var grpItems:FlxTypedGroup<FlxText>;

    var randomDialogue:Array<String> = [
        "Your nose is weird.",
        "Don't worry. I've got an eternity. Can you say the same?",
        "Don't sympathize with evil.",
        "Speaking ill of another man's hat is dishonorable.",
        "I'll have you know I don't appreciate window shoppers."
    ];

    override function create()
    {
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

        itemBox = new OtherBox();
        add(itemBox);
        itemBox.y = 250;

        var dumb = new ShopBox();
        add(dumb);

        prefix = new FlxText(40, 268, 0, '*', 30);
        prefix.font = Paths.font();
        add(prefix);

        dialogue = new FlxTypeText(prefix.x+25, 268, 350, null, 30);
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
        // this is used for the buy sub menu dont worry about it
        grpItems = new FlxTypedGroup<FlxText>();
        add(grpItems);

        for (i => item in shopItems)
        {
            var newItem = new FlxText(50, 268+(i*35), 0, null, 28);
            newItem.font = Paths.font();
            newItem.ID = i;
            newItem.alpha = 0.000001;
            grpItems.add(newItem);
            newItem.text = item[1] + 'G - ' + item[0];

            if (i == 4)
                newItem.text = 'Exit';
        }

        goldText = new FlxText(460, 428, 0, null, 30);
        goldText.font = Paths.font();
        add(goldText);

        itemsText = new FlxText(560, 428, 0, null, 30);
        itemsText.font = Paths.font();
        add(itemsText);

        changeItem();
        updateText(randomDialogue[FlxG.random.int(0, randomDialogue.length - 1)]);
        updateInventory();

        super.create();
    }

    var selectedBuy:Bool = false;
    override function update(elapsed:Float)
    {
        if (!selectedBuy)
        {
            if (Controls.justPressed('menuUp'))
                changeItem(-1);
            if (Controls.justPressed('menuDown'))
                changeItem(1);
            if (Controls.justPressed('confirm'))
                selectItem();
        }
        else
        {
            if (Controls.justPressed('menuUp'))
                changeItemShop(-1);
            if (Controls.justPressed('menuDown'))
                changeItemShop(1);
            if (Controls.justPressed('confirm'))
                buyItem();
            if (Controls.justPressed('cancel'))
                stoppedShopping();
        }

        if (FlxG.keys.justPressed.F)
        {
            FlxG.sound.play(Paths.sound('menuSelect'));
            Settings.data.gold += 100;
            updateInventory();
        }

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

    function updateText(text:String = '')
    {
        dialogue.resetText(text);
        dialogue.start(0.04, true);
    }

    function selectItem()
    {
        FlxG.sound.play(Paths.sound('moveMenu'));

        switch(options[curSelected])
        {
            case 'Buy':
                startedShopping();
            case 'Sell':
                updateText("Why would I buy your shit back? I'm trying to get rid of it, you moron.");
            case 'Talk':
                updateText(randomDialogue[FlxG.random.int(0, randomDialogue.length - 1)]);
            case 'Exit':
                quitting();
        }
    }

    function quitting()
    {
        updateText('Til we meet again, human.');
        dialogue.completeCallback = function()
        {
            new FlxTimer().start(1, function(timer:FlxTimer) {
                #if desktop Sys.exit(1); #end
            });
        }
    }

    // start of the buying sub menu
    // this sucks i know 

    function startedShopping()
    {
        selectedBuy = true;

        // hide the previous items

        prefix.alpha = 0.00001;
        dialogue.alpha = 0.0001;
        grpText.forEach(function(txt:FlxText) {
            txt.alpha = 0.000001;
        });

        FlxTween.tween(itemBox, {y: 80}, 0.5, {ease:FlxEase.quadInOut});

        grpItems.forEach(function(txt:FlxText) {
            txt.alpha = 1;
        });

        otherDialogue = new FlxTypeText(450, 265, 150, "What are ya buyin'?", 28);
        otherDialogue.font = Paths.font();
        otherDialogue.sounds = dialogue.sounds;
        add(otherDialogue);
        otherDialogue.start(0.04, true);

        changeItemShop();
        updateInventory();
    }

    function stoppedShopping()
    {
        // kill him KILL HIM. KILL HIM NOWWW
        grpItems.forEach(function(txt:FlxText){
            txt.alpha = 0.00001;
        });
        otherDialogue.kill();
        FlxTween.tween(itemBox, {y: 250}, 0.5, {ease:FlxEase.quadInOut});

        // show the other items again
        prefix.alpha = 1;
        dialogue.alpha = 1;
        grpText.forEach(function(txt:FlxText) {
            txt.alpha = 1;
        });

        selectedBuy = false;
        updateText(randomDialogue[FlxG.random.int(0, randomDialogue.length - 1)]);
        changeItem();
    }

    function changeItemShop(change:Int = 0)
    {
        FlxG.sound.play(Paths.sound('moveMenu'));

        curItem = FlxMath.wrap(curItem + change, 0, shopItems[0].length + 1);

        grpItems.forEach(function(txt:FlxText)
        {
            if (txt.ID == curItem)
                soul.setPosition(txt.x - 20, txt.y + 10);
        });

        itemBox.updateItemText(shopItems[curItem][2]);
    }

    function buyItem()
    {
        if (curItem == 4)
            stoppedShopping();
        else
        {
            if (Settings.data.gold >= shopItems[curItem][1])
            {
                FlxG.sound.play(Paths.sound('buyItem'));
                trace('You bought ' + shopItems[curItem][0]);
                Settings.data.gold -= shopItems[curItem][1];
    
                if (Settings.data.curSpace == Settings.data.maxSpace)
                    updateTextShop("Running out of space?");
                else
                    Settings.data.curSpace += 1;

                Settings.save();
            }
            else
            {
                FlxG.sound.play(Paths.sound('moveMenu'));
                updateTextShop('You cannot be serious.');
            }
            updateInventory();
        }
    }

    function updateInventory()
    {
        goldText.text = Settings.data.gold + 'G';
        itemsText.text = Settings.data.curSpace + '/' + Settings.data.maxSpace;
    }

    function updateTextShop(text:String = '')
    {
        otherDialogue.resetText(text);
        otherDialogue.start(0.04, true);
    }
}