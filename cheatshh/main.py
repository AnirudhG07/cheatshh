import os
import subprocess
import shutil
import pkg_resources
import sys
import argparse

def post_install():
    config_path = os.path.join(os.path.expanduser('~'), '.config', 'cheatshh')
    try:
        # Check if the directory exists
        if not os.path.exists(config_path):
            # If not, create it
            os.makedirs(config_path)
            # Copy the files from the package to the new config path
            for file_name in ['cheats.sh', 'groups.json', 'commands.json', 'cheatshh.toml']:
                file_path = pkg_resources.resource_filename(__name__, file_name)
                shutil.copy2(file_path, os.path.join(config_path, file_name))
            # Make cheats.sh executable
            subprocess.call(['chmod', '+x', os.path.join(config_path, 'cheats.sh')])
    except:
        print("Error: Could not create {} directory. Please retry or report issue to official Github page.".format(config_path))
    return

def cheatshh(args):
    try:
        subprocess.call([os.path.join(os.path.expanduser('~'), '.config', 'cheatshh', 'cheats.sh')] + args)
    except Exception as e:
        print(f"Error: {e}.\n Could not run cheatshh.")

def main():
    """
    Cheatshh main function simply calls cheats.sh function which is the main function of cheats.sh.
    It is a simple wrapper around cheats.sh using python.
    This function will also create $HOME/.config/cheatshh directory if it does not exist.
    """
    post_install()
    cheatshh(sys.argv[1:])

    return