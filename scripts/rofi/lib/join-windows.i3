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

i3-msg "[con_id=\"__focused__\"] mark join_target"
i3-msg "[con_id=\"__focused__\"] splith"
i3-msg "[id=\"${1}\"] move to mark join_target"
i3-msg "unmark join_target"
i3-msg "[id=\"${1}\"] focus"

