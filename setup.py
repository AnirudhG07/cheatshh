import os
import shutil
import subprocess, gzip
from setuptools import find_packages, setup
from setuptools.command.install import install


class CustomInstallCommand(install):
    def run(self):
        install.run(self)  # Run standard install logic
        post_install()


def install_man_page():
    source_path = os.path.join("docs", "man", "cheatshh.1")
    dest_path = os.path.join("/usr/local/", "share", "man", "man1", "cheatshh.1.gz")

    # Compress the man page
    with open(source_path, 'rb') as src, gzip.open(dest_path, 'wb') as dst:
        shutil.copyfileobj(src, dst)


def post_install():
    install_man_page()
    
    # Get the directory containing setup.py
    setup_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Define the path to ~/.config/cheatshh
    config_dir = os.path.expanduser("~/.config/cheatshh")
    # Create ~/.config/cheatshh directory if it doesn't exist
    os.makedirs(config_dir, exist_ok=True)
    
    # Define files to copy with their respective paths
    files_to_copy = [
        ("cheats.sh", "cheats.sh"),
        ("commands.json", "commands.json"),
        ("groups.json", "groups.json"),
        ("README.md", "README.md"),
        ("requirements.txt", "requirements.txt")
    ]
    # Copy files to ~/.config/cheatshh
    for file_name, src_file in files_to_copy:
        src_path = os.path.join(setup_dir, src_file)
        dest_path = os.path.join(config_dir, file_name)
        shutil.copy(src_path, dest_path)


def run_cheatshh():
    subprocess.run(["bash", "~/.config/cheatshh/cheats.sh"])


setup(name="cheatshh", version="1.0.3", cmdclass={"install": CustomInstallCommand},
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
1.0.3

## Note:
- This package is best used in Unix based systems, like linux and MacOS. For Windows, see the github repository for more details.
- The package is installed in ~/.config/cheatshh directory.

## Bugs fixed in 1.0.3
- Path configuration for Linux has been fixed.
- docs has been updated.

""",
    long_description_content_type="text/markdown",
    keywords=["cheatsheet, cheat, command-line, cli"],
    install_requires=["fuzzyfinder", "whiptail"],
    author="Anirudh Gupta",
    packages=find_packages(),
    entry_points={
        "console_scripts": [
            "cheatshh=src.run_cheatshh:main",
        ],
    },
)
