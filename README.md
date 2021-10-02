# Moonglasses

Craft new item Moonglasses to activate all 3 sunglasses buffs at the same time:
* highlight plants, NPCs and mutants in green (vanilla Classic Sunglasses effect)
* highlight collectible items in blue (vanilla Sunglasses effect)
* highlight machines in red (vanilla Modern Sunglasses effect)


And the best thing - you don't even have to wear them!

This repo contains tools and files necessary for creation of Moonglasses.

## Instructions

Below instructions assume `Elex` folder from this repo was copied to Elex instalation directory. Some of the steps require it. I've left some of the files produced in the process so everyone can check if everything is going according to the instruction.

## Altering existing item and creating new item

1. Go to `Elex/data/packed`
2. Unpack `c_1_na.pak` with `elexresman.exe` (drag and drop), choose number corresponding to `0_na_tpl (Template)`, this will create `c_1_na/Template` directory with templates for all times in game (and more)
3. From `c_1_na/template` directory copy `It_Sun_SenseLife.elextpl` to `m_2_moonglasses_normal\Template`
4. To edit existing item unpack `m_2_moonglasses_normal\Template\It_Sun_SenseLife.elextpl` with `elexresman.exe` (drag and drop), this will create `m_2_moonglasses_normal\Template\It_Sun_SenseLife.elextpldoc`. You can edit `*.elextpldoc` files with any text editor. For this mode class `gCRecipe_PS` was added so player could create Moonglasses while having Classic Sunglasses in inventory.
5. To create new item copy `m_2_moonglasses_normal\Template\It_Sun_SenseLife.elextpldoc` to `m_2_moonglasses_normal\Template\It_TinyHatastrophe_Moonglasses.elextpldoc`. Replace `It_TinyHatastrophe_Moonglasses` inside new file with `It_TinyHatastrophe_Moonglasses`. It doesn't contains `gCRecipe_PS` class, but have new GUID (it have to be unique!), and `OnLinkScript`, `OnEquipScript` and `OnPossessScript` were changed to apply buffs from Classic Sunglasses, Sunglasses and Modern Sunglasses when item is obtained/equiped. Make sure GUID is the same as in `ResultItem` in `gCRecipe_PS` in `It_Sun_SenseLife.elextpldoc`!
6. Pack both `*.elextpldoc` with `elexresman.exe` (drop and drop, one at the time) This will overwrite `*.elextpl` files.
7. Remove both `*.elextpldoc`
8. Pack whole `m_2_moonglasses_normal` folder with `elexresman.exe` (drag and drop). When asked for archive generation, choose `2`. It will create `m_2_moonglasses_normal.pak` file that will be automatically loaded up while Elex is launched, as long as it stays in `Elex/data/packed`. 

## Adding strings for newly created file

1. Go to `Elex/data/packed` and unpack `c_1_en.pak` with `elexresman.exe` (drag and drop), choose number corresponding to `localization`. This will create `c_1_en/localization` directory with `en.str` file.
2. Copy `en.str` from `Elex/data/packed/c_1_en/localization` to `Elex/data/compiled/localization`
3. Launch `lianzifu-unpack.elex.cmd` from `Elex` directory. This will unpack `en/.str` from `Elex/data/compiled/localization` to `*.csv` files in `Elex\data\raw\strings`. Each string is put into corresponding `*.csv` file, but unpacking script is missing some definitions to translate IDs to text so many strings end in default file `strings.csv`.
4. Open `Elex\data\raw\strings\item.csv`. Cell A1 contains header format we have to follow, each entry needs to be added in cells directly below. ID is created by prefix + code name of item. Add `ITEM_It_TinyHatastrophe_Moonglasses|Moonglasses` (without any formatting) to add `Moonglasses` in-inventory name for item created by `It_TinyHatastrophe_Moonglasses` file (prefix is `ITEM_`). For item description prefix is `ITEMDESC`, for item name in game world (when Jax is looking at it) prefix is `FO`.
5. Run `Elex\lianzifu-pack.elex.cmd`. This will create `new_en.str` in `Elex/data/compiled/localization` based on `*.csv` files in `Elex\data\raw\strings`
6. Copy `Elex/data/compiled/localization/new_en.str` to `ELEX\data\packed\m_2_moonglasses_normal\localization`
7. Pack whole `m_2_moonglasses_normal` folder with `elexresman.exe` (drag and drop). When asked for archive generation, choose `2`. It will create `m_2_moonglasses_normal.pak` file that will be automatically loaded up while Elex is launched, as long as it stays in `Elex/data/packed`. 
