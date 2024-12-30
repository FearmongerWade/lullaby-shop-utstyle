package backend;

import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

class Controls
{
    public static var keybinds:Map<String, Array<FlxKey>> =
    [
        /* 
            these would be for moving in the game, however as soon as you press them you trigger
            cartridge guy, so sadly, no movement
            :(
        */
        'movement' => [LEFT, DOWN, UP, RIGHT],

        // hardcoded for menu movement (and to save myself from the stress)
        'menuLeft' => [LEFT],
        'menuDown' => [DOWN],
        'menuUp'   => [UP],
        'menuRight'=> [RIGHT],

        'confirm' => [Z, ENTER],
        'cancel'  => [X, SHIFT],
        'menu'    => [C, CONTROL]
    ];

    public static var defaultKeys:Map<String, Array<FlxKey>> = keybinds;

    static var coolSave:FlxSave;

    // -- Backend -- // 

    public static function pressed(name:String)
        return FlxG.keys.anyPressed(defaultKeys[name]);

    public static function justReleased(name:String)
        return FlxG.keys.anyJustReleased(defaultKeys[name]);

    public static function justPressed(name:String)
        return FlxG.keys.anyJustPressed(defaultKeys[name]);

    public static function load() 
    {
		if (coolSave == null) 
        {
			coolSave = new FlxSave();
			coolSave.bind('controls', 'FearmongerWade');
		}

		if (coolSave.data.keyboard != null) 
        {
			var loadedKeys:Map<String, Array<FlxKey>> = coolSave.data.keyboard;
			for (control => keys in loadedKeys) 
				if (keybinds.exists(control))
				    keybinds.set(control, keys);
		}
    }
}