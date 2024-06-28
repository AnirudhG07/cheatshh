# cheatshh ![Static Badge](https://img.shields.io/badge/version-1.1.1-blue)

Cheatshh is an interactive CLI meant for managing command line cheatsheets, written in shell script. Now you don't have to remember CLI commands and just refer your cheatsheet. You can group commands and view their TLDR(or anyother) and MAN pages along with a custom description for the command.
<br>

> **Note:** This software is tested on and initially configured for MacOS. Please check out the [configuration documentation] to set it up for your system.

## Table of Contents

* [Preview/Screenshots ](#previewscreenshots-)
* [Features](#features)
* [Installation](#installation)
  * [Pip Installation](#pip-installation)
  * [Homebrew Installation](#homebrew-installation)
  * [Manual Installation through git clone](#manual-installation-through-git-clone)
    * [For MacOS and Linux](#for-macos-and-linux)
    * [For Windows](#for-windows)
* [Libraries and Groups](#libraries-and-groups)
* [Bookmarking](#bookmarking)
* [Dependencies](#dependencies)
* [Cheatshh Configuration](#cheatshh-configuration)
* [Saving cheatshh](#saving-cheatshh)
* [Trouble-shooting](#trouble-shooting)
* [Documentation](#documentation)
* [Check it out](#check-it-out)
* [Contributing](#contributing)
    * [Contribution Guidelines](#contribution-guidelines)


# Preview/Screenshots 

https://github.com/AnirudhG07/cheatshh/assets/146579014/d064f201-2b2f-46b3-a341-7b913646e4ef

# Features

- Comprehensive cheatsheets for various command-line utilities and tools.
- Easy-to-use interface for quickly accessing and executing commands, powered by fuzzy finder(fzf) and whiptail.
- Customizable cheatsheets and groups to suit your needs.
- TLDR(any more) and MAN pages visible in the preview.
- Easy to add, edit, delete commands & groups and play around.
- Bookmark commands to access them outside of group as well.
- Change configurations like colors, automatic man page display, usages of other cheatsheets like tldr, cheats.sh, etc.

# Installation

The following installation guidelines hold for Linux and MacOS.<br>
You can download cheatshh through following ways- (more will be added soon)

## Pip Installation

Before running the below commands, make sure your dependencies are satisfied. See the DEPENDENCIES section for more info.
From your command line, run-

```bash
pip install cheatshh
```

This will create ~/.config/cheatshh in your home directory. Now simply run-

```bash
cheatshh
```

and you are done. Use various options to add, edit and delete commands and groups.

## Homebrew Installation

This tool can also be installed using Homebrew(for MacOS only). You can install it by tapping my homebrew-tap repo and installing the tool.

```bash
brew tap AnirudhG07/AnirudhG07
brew install cheatshh
```

You can now run the tool by running `cheatshh -h` in your terminal. If you are facing issues, try running-

```bash
brew install AnirudhG07/AnirudhG07/cheatshh # After tapping the repo
```

Make sure you have Homebrew installed in your MacOS and it is updated which can be done by running `brew update`.

## Manual Installation through git clone

You can setup manual installation with the following guidelines-

### For MacOS and Linux

1. Clone the repository

```bash
git clone https://github.com/AnirudhG07/cheatshh
```

2. Navigate to the project directory run below if downloaded in home directory

```bash
cd ~/cheatshh
```

3. Install the requirements through

```
pip install -r requirements.txt
```

4. (optional) Make sure you have `poetry` installed which will be required to build the project. If not you can run either of the below commands-
```bash
pip install poetry
# OR
curl -sSL https://install.python-poetry.org | python -
```
This will download `peotry`. Now you can proceed to the next step.

5. Run the below code to set cheatshh

```bash
pip install .
```

Now you should be able to use the tool by running `cheatshh` in your terminal. Feel free to raise an issue if any error comes up.

## For Windows

For Windows, you can use Virtual Machines of Linux, or change configurations manually.<br>
> From version >= 1.1.1, the configurations for having `cheatshh` on Windows has greatly been improved. 

- Change the path to directory `~/.config/cheatshh` to `absolute/path/to/your/directory/cheatshh`, by using grep command in the cheatshh directory, in `cheatshh.toml` and `cheats.sh` only at the one place.

- This should run cheatshh appropriately. Make sure the dependencies are installed, since they are easily available for Unix applications.

# Libraries and Groups

You can create custom groups using-

```bash
cheatshh -g
```

We also have premade libraries of groups <a href="https://github.com/AnirudhG07/cheatshh/tree/main/library"> here </a> which you can download with the instructions given there itself. <br>
We welcome you to publish your own libraries for everyone to see.

# Bookmarking
Bookmarking let's you save your command in the main preview despite them being present in a group.<br>
You can bookmark a command by pressing Enter and selecting `Bookmark`. Now you don't need to find it in a group and access it in the main preview.<br>You can always remove Bookmark of a command by pressing Enter and selecting `Remove Bookmark`.

# Dependencies

Cheatshh uses the following as its main tools. Ensure that these are pre-installed in your computer.

- fuzzy finder(fzf)
- whiptail
- jq
- yq
**NOTE:** jq and yq used in the package is the version present in Homebrew. Thus please install that instead of from Pypi.(It didn't work for me.)<br>

In MacOS, you can use HomeBrew to install the above packages with-

```bash
brew install <package>
```

For MacOS & Linux both, you can run the following command to download the packages.

```bash
sudo apt install <package>
```

For Windows, you can use your favourite package manager or download from their website itself.

# Cheatshh Configuration
You can change various configurations of cheatshh like colors, automatic man page display, usages of other cheatsheets like tldr, cheats.sh, etc. You can do this by going to the `cheatshh/cheatshh.toml` file and changing the values as per your needs.<br>
**NOTE:** All the instructions on how to change suitably is mentioned within the file itself. If you are facing any issues, feel free to raise an issue.

# Saving cheatshh
When you have configured your cheatshh, you would definitely want to save them. If you want to use cheatshh in some different machine without rewriting again(cause that's a lot of trouble). Here's how you can save it.
1. Make a repository by the name `Your_handle/cheatshh` or any other name. You can also add it to your repo where you are storing your dot files.
2. You can use `stow` command to configure everything in an instant. Here's the layout of the directory if you will use stow-
   
```markdown
cheatshh
└─── .config
       └── cheatshh
            ├── cheats.sh
            ├── commands.json
            ├── groups.json
            └── any/other/file
```

Now you can simply download this directory, run `stow cheatshh`, this will setup your cheatshh in the `.config/cheatshh` as it should be.<br>
OR you can manually set it up, in that case you don't need the above tree, you can simply use have the last level of tree inside cheatshh directory. 
<br>

Don't forget to make `setup.sh` executable.

# Trouble-shooting
1. If you are facing issues with `jq` and `yq`, please try the following first - 
- Add ABSOLUTE PATH of your `.config/cheatshh` in the `cheatshh.toml` and `cheats.sh` file as pointed [for Windows](#for-windows)
- The jq and yq used in the packages is from Homebrew and Pypi yq would not work. So make sure you have that `jq` and `yq` installed.

2. If permission denial error shows up, run the same command using sudo. You will have to provide password in this case.

```bash
sudo <command-name>
```

This might be needed in the case for man page display or maybe for installation of dependency.

3. If `WARNING: The script cheatshh is installed in '/home/admin/.local/bin' which is not on PATH.` error comes, then cheatshh script has to be included in the system PATH, you can add the following lines to the appropriate shell configuration.

- BASH: Add the following at the end of ~/.bashrc

```bash
export PATH="$HOME/.local/bin:$PATH"
```

- ZSH: Add the following at the end of ~/.zshrc

```bash
export PATH="$HOME/.local/bin:$PATH"
```

After adding these lines, either restart your terminal or run source on the respective configuration file to apply the changes. For example:

```bash
source ~/.bashrc  # For Bash
source ~/.zshrc   # For Zsh
```

This should add the path in your `shell-rc` file and you should be able to run.<br>
Note: If you are using some other shell like fish or any similar other, configure the settings accordingly. Using Fish is not recommended for this tool.
 
# Documentation

Cheatshh is an interactive, easy CLI tool to maintain your custom cheatsheets. You can check our the <a href="https://github.com/AnirudhG07/cheatshh/tree/1.1.1/docs"> docs </a> to see how to use cheatshh.

# Check it out
Check out my Yazi File manager plugin for cheatshh at [cheatshh.yazi](https://github.com/AnirudhG07/cheatshh.yazi). You can save your yazi shell commands and easily access them within Yazi.

# Contributing

I would love to take contributions from the community! If you have suggestions for new cheatsheets, improvements to existing ones, or bug fixes, please feel free to submit a pull request. 
### Contribution Guidelines
1) For contribution of a library, it should have a suitable folder name(max 3 words) with commands.json and groups.json, similar to the format in other libraries. The `group` field should be "yes", `bookmark` field should be "no".
2) For bug fixes, it will be great if you could discuss first in Issues before directly putting a PR. 
3) It would be great to publish this in other package managers. So I would request help for publishing to different package managers.
