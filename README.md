# cheatshh

Cheatshh is an interactive CLI meant for managing command line cheatshheets, written in shell script. Now you don't have to remember CLI commands and just refer your cheatshhet. You can group commands and view their TLDR and MAN pages along with a custom description for the command.

# Features

- Comprehensive cheatsheets for various command-line utilities and tools.
- Easy-to-use interface for quickly accessing and executing commands, powered by fuzzy finder(fzf) and whiptail.
- Customizable cheatshheets and groups to suit your needs.
- TLDR and MAN pages visible in the preview.
- Easy to add, edit, delete commands and groups and playing around.

# Installation
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

# Documentation
Cheatshh is an interactive, easy CLI tool to maintain your custom cheatshheets. You can check our the <a href="https://github.com/AnirudhG07/cheatshh/tree/main/docs"> docs </a> to see how to use cheatshh.

# Contributing
I would love to take contributions from the community! If you have suggestions for new cheatsheets, improvements to existing ones, or bug fixes, please feel free to submit a pull request.
