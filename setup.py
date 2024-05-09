import os
import shutil, subprocess
from setuptools import setup, find_packages
from setuptools.command.install import install

class CustomInstallCommand(install):
    def run(self):
        install.run(self)  # Run standard install logic
        post_install()

def install_man_page():
    source_path = os.path.join('docs', 'man', 'cheatshh.1')
    dest_path = os.path.join('/usr/local/','share', 'man', 'man1', 'cheatshh.1')
    os.makedirs(os.path.dirname(dest_path), exist_ok=True)
    try:
        shutil.copy(source_path, dest_path)
    except PermissionError:
        print("Permission denied. Please run this script as root for man pages.")


def post_install():
    install_man_page()
    # Define the path to ~/.config/cheatshh
    config_dir = os.path.expanduser("~/.config/cheatshh")

    # Create ~/.config/cheatshh directory if it doesn't exist
    os.makedirs(config_dir, exist_ok=True)

    # Copy files to ~/.config/cheatshh
    files_to_copy = ["cheats.sh", "commands.json", "groups.json", "README.md", "requirements.txt"]
    for file_name in files_to_copy:
        with open(file_name, "rb") as src:
            with open(os.path.join(config_dir, file_name), "wb") as dest:
                dest.write(src.read())

def run_cheatshh():
    subprocess.run(['bash', '~/.config/cheatshh/cheats.sh'])


setup(name="cheatshh", version="1.0.2", cmdclass={"install": CustomInstallCommand}, 
    long_description="""
# cheatshh

Cheatshh is an interactive CLI meant for managing command line cheatshheets. Now you don't have to remember CLI commands and just refer your cheatshhet. You can group commands and view their TLDR and MAN pages along with a custom description for the command.

# Features

- Comprehensive cheatsheets for various command-line utilities and tools.
- Easy-to-use interface for quickly accessing and executing commands, powered by fuzzy finder(fzf) and whiptail.
- Customizable cheatshheets and groups to suit your needs.
- TLDR and MAN pages visible in the preview.
- Easy to add, edit, delete commands and groups and playing around.
- Press Enter on a command to copy it to clipboard and exit.

Visit the Github Repository for more details: https://github.com/AnirudhG07/cheatshh

# Version
1.0.2

## Note:
- This package is best used in Unix based systems, like linux and MacOS. For Windows, see the github repository for more details.
- The package is installed in ~/.config/cheatshh directory.


""",
    long_description_content_type="text/markdown",
    keywords=["cheatsheet, cheat, command-line, cli"],
    install_requires=["fuzzyfinder", "whiptail"],
    author="Anirudh Gupta",
    packages=find_packages(),
    entry_points={
        'console_scripts': [
            'cheatshh=src.run_cheatshh:main',
        ],
    },
)

