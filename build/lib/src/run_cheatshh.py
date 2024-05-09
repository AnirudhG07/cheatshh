# src/run_cheatshh.py
import subprocess
import os
import sys

def main():
    script_path = os.path.join(os.path.expanduser('~'), '.config', 'cheatshh', 'cheats.sh')
    subprocess.run(['bash', script_path] + sys.argv[1:])