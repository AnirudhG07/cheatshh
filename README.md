# cheatshh

Cheatshh is an interactive CLI meant for managing command line cheatshheets. Now you don't have to remember CLI commands and just refer your cheatshhet. You can group commands and view their TLDR and MAN pages along with a custom description for the command.

## Features

- Comprehensive cheatsheets for various command-line utilities and tools.
- Easy-to-use interface for quickly accessing and executing commands, powered by fuzzy finder(fzf) and whiptail.
- Customizable cheatshheets and groups to suit your needs.
- TLDR and MAN pages visible in the preview.
- Easy to add, edit, delete commands and groups and playing around.

## How to use
You can download cheatshh through following ways- (more will be added soon)
### Pip Installation 
From your command line, run-
```bash
pip install cheatshh
```
This will create ~/.config/cheatshh in your home directory. Now simply run-
```bash
cheatshh
```
and you are done. Use various options to add, edit and delete commands and groups.

### Manual Installation through git clone
1. Clone the repository
```bash
git clone https://github.com/AnirudhG07/cheatshh
```
2. Navigate to the project directory(run below if downloaded in home directory
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




