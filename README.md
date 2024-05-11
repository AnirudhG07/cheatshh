# cheatshh ![Static Badge](https://img.shields.io/badge/version-1.0.3-blue)

Cheatshh is an interactive CLI meant for managing command line cheatshheets, written in shell script. Now you don't have to remember CLI commands and just refer your cheatshhet. You can group commands and view their TLDR and MAN pages along with a custom description for the command.

# Features

- Comprehensive cheatsheets for various command-line utilities and tools.
- Easy-to-use interface for quickly accessing and executing commands, powered by fuzzy finder(fzf) and whiptail.
- Customizable cheatshheets and groups to suit your needs.
- TLDR and MAN pages visible in the preview.
- Easy to add, edit, delete commands and groups and playing around.

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
4. Run the `setup.py` code to set cheatshh
```bash
python setup.py install
```
Now you should be able to use the tool by running ```cheatshh``` in your terminal. Feel free to raise an issue if any error comes up.

## For Windows
For Windows, you can use Virtual Machines of Linux, or change configurations manually.<br>
- Change the path to directory `~/.config/cheatshh` to `/path/to/your/directory/cheatshh`, by using grep command
in the cheatshh directory, in `setup.py`,`cheats.sh` and manually setting up `./src/run_cheatshh.py`.

- This should run cheatshh appropriately. Make sure the dependencies are installed, since they are easy available for Unix applications.

# Libraries and Groups
You can create custom groups usig-
```bash
cheatshh -g
```
We also have premade libraries of groups <a href="https://github.com/AnirudhG07/cheatshh/tree/main/library"> here </a> which you can download with the instructions given there itself. <br>
We welcome you to publish your own libraries for everyone to see.

# Dependencies
Cheatshh uses the following as its main tools. Ensure that these are pre-installed in your computer.
- fuzzy finder
- whiptail
- jq

In MacOS, you can use HomeBrew to install the above packages with-
```bash
brew install <package>
```
For MacOS & Linux both, you can run the following command to download the packages.
```bash
sudo apt install <package>
```
For Windows, you can use your favourite package manager to download the packages,

# Trouble-shooting
1) If permission denial error shows upm run the same command using sudo. You will have to provide password in this case. 
```bash
sudo <command-name>
```
    This might be needed in the case for man page display or maybe for installation of dependency.
2) If `WARNING: The script cheatshh is installed in '/home/admin/.local/bin' which is not on PATH.` error comes, then cheatshh script has to be included in the system PATH, you can add the following lines to the appropriate shell configuration.
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
This should add the path in your shell-rc file and you should be able to run.<br>
Note: If you are using some other shell like fish or any other, configure the settings accordingly. Using Fish is not recommended for this tool.

# Documentation
Cheatshh is an interactive, easy CLI tool to maintain your custom cheatshheets. You can check our the <a href="https://github.com/AnirudhG07/cheatshh/tree/1.0.3/docs"> docs </a> to see how to use cheatshh.

# Contributing
I would love to take contributions from the community! If you have suggestions for new cheatsheets, improvements to existing ones, or bug fixes, please feel free to submit a pull request.
