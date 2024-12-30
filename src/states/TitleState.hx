package states;

import flixel.util.FlxStringUtil;

class TitleState extends FlxState
{
    var defaultSize:Int = 28;

    var curSelected = 0;
    var options:Array<String> = ['Continue', 'Settings'];
    var grpOptions:FlxTypedGroup<FlxText>;

    override function create()
    {
        FlxG.sound.playMusic(Paths.music('startMenu'));

        var bg = new FlxSprite().loadGraphic(Paths.image('start/bg'));
        add(bg);

        var versionText = new FlxText(0, 0, 0, "undertale fangame by _fearmonger", 16);
        versionText.setFormat(Paths.font('Mars_Needs_Cunnilingus.ttf'), 16, 0xff808080, CENTER);
        versionText.screenCenter(X);
        add(versionText);
        versionText.y = FlxG.height - versionText.height - 2;

        // ui shit

        var name = new FlxText(140, 128, 0, 'Chara', defaultSize);
        name.font = Paths.font();
        add(name);

        var lv = new FlxText(0, 128, 0, 'LV1', defaultSize);
        lv.font = Paths.font();
        lv.screenCenter(X);
        add(lv);

        var playtime = new FlxText(425, 128, 0, '', defaultSize);
        playtime.font = Paths.font();
        playtime.alignment = RIGHT;
        add(playtime);
        playtime.text = FlxStringUtil.formatTime(Settings.data.gameTime, false);

        var place = new FlxText(140, 168, 0, '???', defaultSize);
        place.font = Paths.font();
        add(place);

        // selectable text

        grpOptions = new FlxTypedGroup<FlxText>();
        add(grpOptions);

        for (i in 0...options.length)
        {
            var item = new FlxText(170+(i*175), 228, 0, options[i], defaultSize);
            item.font = Paths.font();
            item.ID = i;
            grpOptions.add(item);
        }

        changeItem();
        super.create();
    }

    override function update(elapsed:Float)
    {
        if (Controls.justPressed('menuLeft'))
            changeItem(-1);
        if (Controls.justPressed('menuRight'))
            changeItem(1);
        if (Controls.justPressed('confirm'))
            selectItem();

        super.update(elapsed);
    }

    function changeItem(change:Int = 0)
    {
        curSelected = FlxMath.wrap(curSelected + change, 0, options.length - 1);

        grpOptions.forEach(function(txt:FlxText)
        {
            txt.color = FlxColor.WHITE;

            if (txt.ID == curSelected)
                txt.color = 0xffffff00;
        });

        FlxG.sound.play(Paths.sound('moveMenu'));
    }   

    function selectItem()
    {
        switch(options[curSelected])
        {
            case 'Continue': 
                FlxG.switchState(new ShopState());
            case 'Settings':
                trace('opened the settings menu');
            default: // crash prevention
                FlxG.resetState();
        }
    }
}