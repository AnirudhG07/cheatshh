#!/bin/bash

# Define color codes
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
RED='\033[0;31m' # Red

# Export color codes
export CYAN
export YELLOW
export NC

display_man=false

# Get the directory of the current script

# Check for flags
### ADDITION ###
addition(){
    while true; do
      new_command=$(whiptail --inputbox "Enter new command: (Press TAB to select Ok/Cancel)" 8 78 --title "Add Command" 3>&1 1>&2 2>&3)
      
      exit_status=$?
      if [ $exit_status = 1 ]; then
        exit 1
      fi

      # Check if command is empty or contains spaces
      if [[ -z "$new_command" ]] || [[ "$new_command" =~ ^[[:space:]] ]]; then
        whiptail --msgbox "INVALID COMMAND ENTRY: $new_command\nThe command should not be \"\" or begin with \" \" character." 8 78 --title "Error" 
        continue
      fi

      # Check if command already exists in the JSON file
      if jq --arg cmd "$new_command" 'has($cmd)' /Volumes/Anirudh/Coding/cheatshh/commands.json | grep -q true; then
        if ! whiptail --yesno "Command already there. Would you like to re-enter?" 8 78 --title "Confirmation"; then
          exit 1
        fi
        continue
      fi

      # Ask if it is an alias
      if whiptail --yesno "Is the command an alias?" 8 78 --title "Confirmation"; then
        is_alias="yes"
        description=$(whiptail --inputbox "Enter description for the command: (use \\n for new line)" 8 78 --title "Add Command Description" 3>&1 1>&2 2>&3)
      else
        is_alias="no"
        # Check if tldr page for the command exists
        if ! tldr $new_command --color > /dev/null 2>&1; then
          # Check if man page for the command exists
          if ! man $new_command > /dev/null 2>&1; then
            whiptail --msgbox "Error: Neither man page nor tldr exists for the command: $new_command\nPlease add it as an alias." 8 78 --title "Error" 
            continue
          fi
        fi
        description=$(whiptail --inputbox "Enter description for the command: (use \\ n for new line)" 8 78 --title "Add Command Description" 3>&1 1>&2 2>&3)
      fi

    # Ask if the command should be added to a group
    if whiptail --yesno "Do you want to add the command to a group?" 8 78 --title "Confirmation"; then
        group=$(whiptail --inputbox "Enter the name of the group: (Press TAB to select Ok/Cancel)" 8 78 --title "Add to Group" 3>&1 1>&2 2>&3)
        # Check if the group exists
        if [ "$(jq -r --arg group "$group" '.[$group]' /Volumes/Anirudh/Coding/cheatshh/groups.json)" != "null" ]; then
          # Add the command to the group
          jq --arg group "$group" --arg cmd "$new_command" '.[$group].commands += [$cmd]' /Volumes/Anirudh/Coding/cheatshh/groups.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/groups.json
          # Update the group field in the commands.json file
          jq --arg cmd "$new_command" --arg group "$group" '.[$cmd].group = $group' /Volumes/Anirudh/Coding/cheatshh/commands.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/commands.json
          # Update the commands.json file
          jq --arg cmd "$new_command" --arg desc "$description" --arg alias "$is_alias" '.[$cmd] = {"description": $desc, "alias": $alias, "group": $group}' /Volumes/Anirudh/Coding/cheatshh/commands.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/commands.json
        else
          whiptail --msgbox "Group does not exist: $group" 8 78 --title "Error" 
          continue
        fi
    else
        # If not added to a group, update the commands.json file with group as "no"
        jq --arg cmd "$new_command" --arg desc "$description" --arg alias "$is_alias" '.[$cmd] = {"description": $desc, "alias": $alias, "group": "no"}' /Volumes/Anirudh/Coding/cheatshh/commands.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/commands.json
    fi

    break
  done
}
### DELETION ###
deletion_command() {
  cmd_name=$(whiptail --inputbox "Enter name of the command to delete:" 8 78 --title "Delete Command" 3>&1 1>&2 2>&3)
  
  exit_status=$?
  if [ $exit_status = 1 ]; then
    return
  fi

  # Check if the command exists
  if [ "$(jq -r --arg cmd "$cmd_name" '.[$cmd]' /Volumes/Anirudh/Coding/cheatshh/commands.json)" == "null" ]; then
    whiptail --msgbox "Command does not exist: $cmd_name" 8 78 --title "Error" 
    exit 1
  fi

  # Check if the command is in any group
  if [ "$(jq -r --arg cmd "$cmd_name" '.[$cmd].group' /Volumes/Anirudh/Coding/cheatshh/commands.json)" == "null" ]; then
    # If the command is not in any group, ask for confirmation before deleting
    if (whiptail --yesno "Are you sure you want to delete the command: $cmd_name?" 8 78 --title "Confirmation"); then
      # Delete the command
      jq --arg cmd "$cmd_name" 'del(.[$cmd])' /Volumes/Anirudh/Coding/cheatshh/commands.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/commands.json
    fi
  else
    # If the command is in a group, ask which group to delete from
    group_name=$(whiptail --inputbox "Enter name of the group to delete the command from:" 8 78 --title "Delete Command from Group" 3>&1 1>&2 2>&3)
    
    exit_status=$?
    if [ $exit_status = 1 ]; then
      return
    fi

    # Check if the group exists
    if [ "$(jq -r --arg group "$group_name" '.[$group]' /Volumes/Anirudh/Coding/cheatshh/groups.json)" == "null" ]; then
      whiptail --msgbox "Group does not exist: $group_name" 8 78 --title "Error" 
      exit 1
    fi

    # Delete the command from the group
    jq --arg group "$group_name" --arg cmd "$cmd_name" '(.[$group].commands[] | select(. == $cmd)) = null | del(.[$group].commands[] | nulls)' /Volumes/Anirudh/Coding/cheatshh/groups.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/groups.json
  fi
}
### EDITING ###
edition(){
        while true; do
            edit_command=$(whiptail --inputbox "Enter command to edit: (Press TAB to select Ok/Cancel)" 8 78 --title "Edit Command" 3>&1 1>&2 2>&3)
            
            # Check if command exists in the JSON file
            if jq --arg cmd "$edit_command" 'has($cmd)' /Volumes/Anirudh/Coding/cheatshh/commands.json | grep -q false; then
                whiptail --msgbox "Command not found: $edit_command" 8 78 --title "Error" 
                continue
            fi

            break
        done

        current_description=$(jq -r --arg cmd "$edit_command" '.[$cmd].description' /Volumes/Anirudh/Coding/cheatshh/commands.json)
        new_description=$(whiptail --title "Edit Command Description" --inputbox "Current description: $current_description\n\nEnter new description for the command: (use \\n for new line)" 10 78 3>&1 1>&2 2>&3)
        jq --arg cmd "$edit_command" --arg desc "$new_description" '(.[$cmd].description) = $desc' /Volumes/Anirudh/Coding/cheatshh/commands.json > tmp.json && mv tmp.json /Volumes/Anirudh/Coding/cheatshh/commands.json

        if (whiptail --yesno "Do you want to change the group for the command?" 8 78 --title "Change Group"); then
            # Ask the user to enter the new group for the command
            new_group=$(whiptail --inputbox "Enter the new group for the command: (Press TAB to select Ok/Cancel)" 8 78 --title "Edit Command Group" 3>&1 1>&2 2>&3)

            # Check if the group exists
            if [ "$(jq -r --arg group "$new_group" '.[$group]' /Volumes/Anirudh/Coding/cheatshh/groups.json)" == "null" ]; then
                whiptail --msgbox "Group does not exist: $new_group" 8 78 --title "Error" 
                exit 1
            fi

            # Check if the command already exists in the group
            if jq --arg group "$new_group" --arg cmd "$edit_command" '.[$group].commands | index($cmd)' /Volumes/Anirudh/Coding/cheatshh/groups.json | grep -q null; then
                # Update the group of the command in the commands.json file
                jq --arg cmd "$edit_command" --arg group "$new_group" '(.[$cmd].group) = $group' /Volumes/Anirudh/Coding/cheatshh/commands.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/commands.json
                # Add the command to the new group in the groups.json file
                jq --arg group "$new_group" --arg cmd "$edit_command" '.[$group].commands += [$cmd]' /Volumes/Anirudh/Coding/cheatshh/groups.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/groups.json
            else
                whiptail --msgbox "Command already exists in the group! Please recheck the group you want it to add in." 8 78 --title "Error" 
                continue
            fi
        fi
} 

create_group() {
  group_name=$(whiptail --inputbox "Enter name of the new group:" 8 78 --title "Create Group" 3>&1 1>&2 2>&3)
  
  exit_status=$?
  if [ $exit_status = 1 ]; then
    return
  fi

  # Check if the group already exists
  if [ "$(jq -r --arg group "$group_name" '.[$group]' /Volumes/Anirudh/Coding/cheatshh/groups.json)" != "null" ]; then
    whiptail --msgbox "Group already exists: $group_name" 8 78 --title "Error" 
    exit 1
  fi
  
  # Ask for the group description
  group_description=$(whiptail --inputbox "Enter description of the new group: (use \\n for new line)" 8 78 --title "Create Group" 3>&1 1>&2 2>&3)

  exit_status=$?
  if [ $exit_status = 1 ]; then
    return
  fi

  # Add the group to the groups.json file with the description
  jq --arg group "$group_name" --arg desc "$group_description" '.[$group] = {"description": $desc, "commands": []}' /Volumes/Anirudh/Coding/cheatshh/groups.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/groups.json

  # Ask the user if they want to add a command to the group
  if whiptail --yesno "Do you want to add a command to the group?" 8 78 --title "Add Command to Group"; then  
    while true; do
      new_command=$(whiptail --inputbox "Enter new command: (Press TAB to select Ok/Cancel)" 8 78 --title "Add Command" 3>&1 1>&2 2>&3)
      
      exit_status=$?
      if [ $exit_status = 1 ]; then
        exit 1
      fi

      # Check if command is empty or contains spaces
      if [[ -z "$new_command" ]] || [[ "$new_command" =~ ^[[:space:]] ]]; then
        whiptail --msgbox "INVALID COMMAND ENTRY: $new_command\nThe command should not be \"\" or begin with \" \" character." 8 78 --title "Error" 
        continue
      fi

      # Ask if it is an alias
      if whiptail --yesno "Is the command an alias?" 8 78 --title "Confirmation"; then
        is_alias="yes"
        description=$(whiptail --inputbox "Enter description for the command: (use \\n for new line)" 8 78 --title "Add Command Description" 3>&1 1>&2 2>&3)
        # Update the commands.json file
        jq --arg cmd "$new_command" --arg desc "$description" --arg alias "$is_alias" '.[$cmd] = {"description": $desc, "alias": $alias, "group": "no"}' /Volumes/Anirudh/Coding/cheatshh/commands.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/commands.json
      else
        is_alias="no"
        # Check if tldr page for the command exists
        if ! tldr $new_command --color > /dev/null 2>&1; then
          # Check if man page for the command exists
          if ! man $new_command > /dev/null 2>&1; then
            whiptail --msgbox "Neither man page nor tldr exists for the command: $new_command" 8 78 --title "Error" 
            continue
          fi
        fi
        description=$(whiptail --inputbox "Enter description for the command: (use \\n for new line)" 8 78 --title "Add Command Description" 3>&1 1>&2 2>&3)
        # Update the commands.json file
        jq --arg cmd "$new_command" --arg desc "$description" --arg alias "$is_alias" '.[$cmd] = {"description": $desc, "alias": $alias, "group": "no"}' /Volumes/Anirudh/Coding/cheatshh/commands.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/commands.json
      fi
    break
    done
  fi
}

delete_group() {
  group_name=$(whiptail --inputbox "Enter name of the group to delete:" 8 78 --title "Delete Group" 3>&1 1>&2 2>&3)
  
  exit_status=$?
  if [ $exit_status = 1 ]; then
    return
  fi

  # Check if the group exists
  if [ "$(jq -r --arg group "$group_name" '.[$group]' /Volumes/Anirudh/Coding/cheatshh/groups.json)" == "null" ]; then
    whiptail --msgbox "Group does not exist: $group_name" 8 78 --title "Error" 
    exit 1
  fi

  # Ask for confirmation before deleting
  if (whiptail --yesno "Are you sure you want to delete the group: $group_name?" 8 78 --title "Confirmation"); then
    # Get the commands in the group
    group_commands=$(jq -r --arg group "$group_name" '.[$group].commands[]' /Volumes/Anirudh/Coding/cheatshh/groups.json)

    # Delete the group
    jq --arg group "$group_name" 'del(.[$group])' /Volumes/Anirudh/Coding/cheatshh/groups.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/groups.json

    # Delete the commands in the group from commands.json, unless they are also in another group
    for cmd in $group_commands; do
      if ! jq -r --arg cmd "$cmd" 'to_entries[] | select(.value.commands[] == $cmd) | .key' /Volumes/Anirudh/Coding/cheatshh/groups.json | grep -q .; then
        jq --arg cmd "$cmd" 'del(.[$cmd])' /Volumes/Anirudh/Coding/cheatshh/commands.json > temp.json && mv temp.json /Volumes/Anirudh/Coding/cheatshh/commands.json
      fi
    done

    # Go back to the fzf preview page
    display_preview
  fi
}

display_preview() {
  commands=$(jq -r 'to_entries[] | select(.value.group == "no") | .key' /Volumes/Anirudh/Coding/cheatshh/commands.json)
  groups=$(jq -r 'keys[]' /Volumes/Anirudh/Coding/cheatshh/groups.json)
  selected=$(echo -e "$commands\n$groups" | fzf --preview "
    item={};
    alias=\$(jq -r --arg item \"\$item\" '.[\$item].alias' /Volumes/Anirudh/Coding/cheatshh/commands.json);
    echo -e \"${CYAN}COMMAND/GROUP: ${YELLOW}\$item${NC}\n\";

    if jq -e --arg item \"\$item\" '.[\$item]' /Volumes/Anirudh/Coding/cheatshh/groups.json > /dev/null; then
        about=\$(jq -r --arg item \"\$item\" '.[\$item].description' /Volumes/Anirudh/Coding/cheatshh/groups.json);
        echo -e \"${CYAN}GROUP DESCRIPTION:${NC}\";
        if [ -n \"\$about\" ]; then
            echo -e \"${YELLOW}\$about${NC}\n\";
        fi
        group_commands=\$(jq -r --arg item \"\$item\" '.[\$item].commands[]' /Volumes/Anirudh/Coding/cheatshh/groups.json);
        echo -e \"${CYAN}GROUP COMMANDS:${NC} \n\$group_commands\n\";
    else
        about=\$(jq -r --arg item \"\$item\" '.[\$item].description' /Volumes/Anirudh/Coding/cheatshh/commands.json);
        echo -e \"${CYAN}ABOUT:${NC}\";
        if [ -n \"\$about\" ]; then
            echo -e \"${YELLOW}\$about${NC}\n\";
        fi
        echo -e \"${CYAN}ALIAS:${NC} \$alias\n\";
        echo -e \"${CYAN}TLDR:${NC}\";
        echo \"Please wait while the man page is being searched for...\";
        tldr \$item --color;
        if $display_man; then
            echo -e \"\n${CYAN}MAN PAGE: ${NC}\n\";
            echo \"Please wait while the MAN page is being searched for...\";
            man \$item | col -b 
        fi
    fi" --preview-window=right,70%)
  
  # If the user pressed escape, fzf will return an exit status of 130
  if [ $? -eq 130 ]; then
    # Return a special exit status to indicate that the user wants to exit
    return 1
  fi
  # If a command was selected run it
  if [ -n "$selected" ]; then
    if jq -e --arg item "$selected" '.[$item]' /Volumes/Anirudh/Coding/cheatshh/groups.json > /dev/null; then
      display_group_commands "$selected"
    else
      command=$(jq -r --arg item "$selected" '.[$item].alias' /Volumes/Anirudh/Coding/cheatshh/commands.json)
      $command
    fi
  fi
}
display_group_commands() {
  group=$1
  commands=$(jq -r --arg group "$group" '.[$group].commands[]' /Volumes/Anirudh/Coding/cheatshh/groups.json)
  selected_command=$(echo -e "$commands" | fzf --preview "
    cmd={};
    about=\$(jq -r --arg cmd \"\$cmd\" '.[\$cmd].description' /Volumes/Anirudh/Coding/cheatshh/commands.json);
    alias=\$(jq -r --arg cmd \"\$cmd\" '.[\$cmd].alias' /Volumes/Anirudh/Coding/cheatshh/commands.json);
    echo -e \"${CYAN}COMMAND: ${YELLOW}\$cmd${NC}\n\";
    echo -e \"${CYAN}ABOUT:${NC}\";
    if [ -n \"\$about\" ]; then
        echo -e \"${YELLOW}\$about${NC}\n\";
    fi
    echo -e \"${CYAN}ALIAS:${NC} \$alias\n\";
    echo -e \"${CYAN}TLDR:${NC}\n\";
    echo \"Please wait while the tldr page is being searched for...\";
    tldr \$cmd --color;
    if $display_man; then
        echo -e \"\n${CYAN}MAN PAGE: ${NC}\n\";
        echo \"Please wait while the MAN page is being searched for...\";
        man \$item | col -b 
    fi" --preview-window=right,70%)
  # If a command was selected run it
  if [ -n "$selected_command" ]; then
    eval "$(jq -r --arg cmd "$selected_command" '.[$cmd].alias' /Volumes/Anirudh/Coding/cheatshh/commands.json)"
  fi
}


enter_loop=true

case "$@" in
  *'-m'*|*'--man'*)
    display_man=true
    ;;
  *'-a'*|*'--add'*)
    addition
    ;;
  *'-e'*|*'--edit'*)
    edition
    ;;
  *'-dc'*|*'--delete'*)
    deletion_command
    ;;
  *'-g'*|*'--group'*)
    create_group
    ;;
  *'-dg'*|*'--delete-group'*)
    delete_group
    ;;
  *'-h'*|*'--help'*)
    echo "cheatshh - A cheatshheet scripted by you for you to help you remember commands and their usage."
    echo "Usage:"
    echo "    cheatshh [OPTIONS]"
    echo "                                "
    echo "OPTIONS:"
    echo "  -a, --add          Add a new command"
    echo "  -e, --edit         Edit an existing command"
    echo "  -dc, --delete      Delete an existing command"
    echo "  -g, --group        Create a new group"
    echo "  -dg, --delete-group Delete an existing group"
    echo "  -m, --man          Display"
    echo " "
    echo "META OPTIONS"
    echo "  -h, --help         Display this help message"
    echo "  -v, --version      Display the version of cheatshh"
    echo "                                "
    echo "Note: Add -m to display the man pages of the commands in addition to tldr."
    echo "For exampe: cheatshh -a -m OR cheatshh -m"
    echo "                                "
    echo "For more information, please visit: https://github.com/AnirudhG07/cheatshh"
    enter_loop=false
    ;;
  *'-v'*|*'--version'*)
    echo "cheatshh --version 1.0.0"
    enter_loop=false
    ;;
esac

# Check the flag before entering the loop
if $enter_loop ; then
  # Then, enter the display_preview loop
  while true; do
    display_preview
    # If display_preview returned the special exit status, break the loop to exit the script
    if [ $? -eq 1 ]; then
      break
    fi
  done
fi