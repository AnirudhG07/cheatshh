import os

from setuptools import setup


def post_install():
    # Define the path to ~/.config/cheatshh
    config_dir = os.path.expanduser("~/.config/cheatshh")

    # Create ~/.config/cheatshh directory if it doesn't exist
    os.makedirs(config_dir, exist_ok=True)

    # Copy files to ~/.config/cheatshh
    files_to_copy = ["cheats.sh", "commands.json", "groups.json"]
    for file_name in files_to_copy:
        with open(file_name, "rb") as src:
            with open(os.path.join(config_dir, file_name), "wb") as dest:
                dest.write(src.read())

    # Create a symbolic link to cheats.sh in ~/.local/bin
    os.symlink(
        os.path.join(config_dir, "cheats.sh"),
        os.path.expanduser("~/.local/bin/cheatshh"),
    )


setup(name="cheatshh", version="1.0.0", cmdclass={"install": post_install}, 
      long_description="A command-line tool to manage cheatsheets",
      long_description_content_type="text/markdown",
      keywords=["cheatsheet, cheat, command-line, cli"],
      install_requires=["fuzzyfinder", "whiptail"]
)

