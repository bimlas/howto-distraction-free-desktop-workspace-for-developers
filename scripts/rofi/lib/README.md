# User scripts

Collection of scripts to easily navigate between windows.

**You have to align these scripts to your environment to be able to use them!** For example you may have different terminal emulator with different flags.

## Open terminal

Open a terminal and set its title.

## Open project

Open a project directory, name the terminal, fetch latest modifications, show log, etc. Tweak to your needs, for example you can open up VSCode, database manager or whatever you need.

## Group windows

Move the seleced windows to a common workspace. Append the name of the window manager to the script to be able to use in different window managers.

The preferred setting of the window manager is to have a single workspace created by default, where windows appear maximized (or tabbed). Then, the `group-windows` script creates a dynamically tiled workspace when creating a new workspace.

The script have to implement these:

- The argument is the ID of the selected window
- If the selected window and the focused window are on the same workspace, move them to a newly created workspace
  - The name of the created workspace should be `#1`, `#2`, `#3`, ..., to make it easily searchable in the list
  - If there is only one window left on this workspace, move it to the main workspace and delete this workspace
- If the selected window and the focused window are on different workspaces, move the focused window to the workspace of the selected window.

You should disable focus by mouse in your window manager's config, because if it's enabled, the script will move the window under the cursor instead of the keyboard selected window!
