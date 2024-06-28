# Cheatshh Configuration setup Manual
Cheatshh uses a configuration file `cheatshh.toml` to store its various settings and color schemes for user customization. The configuration file is located at `$HOME/.config/cheatshh/config.toml` and is downloaded automatically when you run `cheatshh` for the first time.

`cheatshh.toml` has a lot of comments to guide you through the customization. This document will provide a more detailed explanation of the various settings that you can customize in the configuration file.

# Settings
There are several settings that you can customize in the configuration file. 
## 1. copy_command
This setting allows the terminal to copy the selected command text. The default is set to `pbcopy` for MacOS, but you can change it to `xclip` for Linux, etc. The template of how the command is executed is -
```bash
printf "text"| $copy_command
```
If you would like to add any flags for your clipboard command, you are very welcome to do so. 

## 2. display_group_number
When you are prompted to select a group where you want to add the command into, you are presented with a list of groups for reference. The number of groups to be displayed is set by defualt to 10(maximum value). You can change the number as you like. But remember, the more groups you display, the more cluttered the screen will be.
```bash
display_group_number = 10 
```
It is recommended you keep the number between 10-20.

## 3. man_pages
This enables automatic display of man pages for the selected command in the preview. You can also allow the visibility of man pages using the `--man` or `-m` flag. The default value is set to `false`. 
```bash
man_pages = false
```
You can set it to `true` or `false` depending on your preference.

## 4. cheatshh_home **
This is VERY IMPORTANT SETTING. This sets the path to the directory where cheatshh stores its data. The default value is set to `~/.config/cheatshh`. You can change it to any directory you like. 
```bash
cheatshh_home = "~/.config/cheatshh"
```
**NOTE:** Please provide the ABSOLUTE PATH to avoid crashing.

## 5. notes
This allows you to choose not just TLDR, but any other cheatsheet command you would like to choose like `cheat.sh`, `bropages`, `Cheat`, etc. Here is a list of commands you can input in the configuration file.
```bash
## TLDR PAGES
notes="tldr --color"

## Cheat
notes="cheat"

## cheat.sh
notes="curl cheat.sh"

## eg
notes="eg"

## kb
notes="kb" # OR
notes="kb list"

## bropages
notes="bro"
```
The template of the command usage is -
```bash
notes command_name
```
You can input flags/parameters for them as well.

## 6. full_display
This setting allows you to change display in the main preview. The default value is set to `on`. If you set it as `on`, you will see the below commands/groups in order-
1. ungrouped commands and bookmarked commands
2. groups
3. group_name/group_command

If you set it as `off`, you will see the below commands/groups in order-
1. ungrouped commands and bookmarked commands
2. groups

```bash
full_display = "on"
```
You can set it to `on` or `off` depending on your preference.

## 7. preview_width
The preview width is the space on % of the screen the preview will take. The default value is set to `70`. It is highly recommended to NOT CHANGE THIS. But if you want to, you can change it to any value you like. 
```bash
preview_width = 70
```

# Color Schemes
We provide only two color configurations for now. To set the color, `cheatshh.toml` contains the colors and their respective values to input. Please use them exactly as they are else the shell script will show errors.
```bash
# CYAN='\\033[0;36m'
# YELLOW='\\033[0;33m'
# RED='\\033[0;31m'
# GREEN='\\033[0;32m'
# BLUE='\\033[0;34m'
```
Input the colors as in the configuration file as shown below.
```bash
example_color="\\033[0;32m" # For GREEN Color
```
You can add colors not mentioned in the `cheatshh.toml` file. But make sure you input the correct color code.

## 1. title_color
The title color represents the color of all the titles in the preview. You can change it as you wish. The default value is `CYAN`.
```bash
title_color="\\033[0;36m"
```

## 2. about_color
This denotes the color of the `ABOUT` (description) of the command or group in the preview. The default value is `YELLOW`.
```bash
about_color="\\033[0;33m"
```
You can change these as you like. 
**NOTE:** Changing the color text of MANPAGES might not be possible. For TLDR or any other notes tool, you can set some flags to change the color(if they exist).

### Conclusion    
If you can issues with any of these settings or would like to add more, please feel free to raise an issue on the GitHub repository. 
:q