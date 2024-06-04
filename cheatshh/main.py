import os
import subprocess
import shutil
import pkg_resources

def post_install():
    try:
        # Check if the directory exists
        if not os.path.exists(os.path.expanduser('~/.config/cheatshh')):
            # If not, create it
            os.makedirs(os.path.expanduser('~/.config/cheatshh'))
            # Copy the files from the package to ~/.config/cheatshh
            for file_name in ['cheats.sh', 'groups.json', 'commands.json']:
                file_path = pkg_resources.resource_filename(__name__, file_name)
                shutil.copy2(file_path, os.path.expanduser('~/.config/cheatshh/' + file_name))
            # Make cheats.sh executable
            subprocess.call(['chmod', '+x', os.path.expanduser('~/.config/cheatshh/cheats.sh')])
    except:
        print("Error: Could not create ~/.config/cheatshh directory. Please retry or report issue to official Github page.")
    return

def cheatshh():
    subprocess.call([os.path.expanduser('~/.config/cheatshh/cheats.sh')])

def main():
    """
    Cheatshh main function simply calls cheats.sh function which is the main function of cheats.sh.
    It is a simple wrapper around cheats.sh using python.
    This function will also create ~/.config/cheatshh directory if it does not exist.
    """
    post_install()
    cheatshh()
    return