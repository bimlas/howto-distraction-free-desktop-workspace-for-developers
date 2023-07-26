#!/bin/bash
# i3 4.17.1 implementation
# https://i3wm.org
#
# !!! ATTENTION !!!
#
# You should disable `focus_follows_mouse` in i3 config,
# because if it's enabled, the script will move the window under the
# cursor instead of the keyboard selected window!
#
# https://i3wm.org/docs/userguide.html#_focus_follows_mouse
#
# Dependencies:
# - jq

# Specify name of the main workspace
MAIN_WORKSPACE="1"

function create_workspace()
{
  next="#1"
  for workspace in $(i3-msg -t get_workspaces | jq -r '.[].name'); do
    if [ "x${workspace}" == "x${next}" ]; then
      next="#$(( ${next//\#/} + 1 ))"
    fi
  done
  echo "${next}"
}

function get_window_by_id()
{
  i3-msg -t get_tree | jq -r "recurse(.nodes[]) | select(.window == ${1}) | .id"
}

function get_focused_window()
{
  i3-msg -t get_tree | jq -r 'recurse(.nodes[]) | select(.type == "con" and .focused == true) | .id'
}

function get_window_workspace()
{
  i3-msg -t get_tree | jq -r "recurse(.nodes[]) | select(.type == \"workspace\") | select(recurse(.nodes[]) | contains({id: ${1}})) | .name"
}

function get_windows_count_on_workspace()
{
  i3-msg -t get_tree | jq -r "recurse(.nodes[]) | select(.type == \"workspace\" and .name == \"${1}\") | .nodes | length"
}

focused_client="$(get_focused_window)"
focused_client_workspace="$(get_window_workspace "${focused_client}")"

selected_client="$(get_window_by_id "${1}")"
selected_client_workspace="$(get_window_workspace "${selected_client}")"

if [ "x${focused_client_workspace}" == "x${selected_client_workspace}" ]; then
  workspace="$(create_workspace)"
  i3-msg "[con_id=\"${selected_client}\"]" move workspace "${workspace}"
  i3-msg "[con_id=\"${focused_client}\"]" move workspace "${workspace}"
else
  workspace="${selected_client_workspace}"
  i3-msg "[con_id=\"${focused_client}\"]" move workspace "${workspace}"
fi

if [ "x${focused_client_workspace}" != "x${MAIN_WORKSPACE}" ] && [ "x$(get_windows_count_on_workspace "${focused_client_workspace}")" == "x1" ] ; then
  i3-msg "[workspace=\"${focused_client_workspace}\"]" move workspace "${MAIN_WORKSPACE}"
fi

i3-msg "[con_id=\"${focused_client}\"]" focus
