#!/bin/sh

stack build xmonad xmonad-contrib

ln -fs $(realpath xmonad.hs) ~/.xmonad/
ln -fs $(realpath xmobarrc) ~/.xmobarrc
ln -fs $(realpath stalonetrayrc) ~/.stalonetrayrc
ln -fs $(realpath startup.sh) ~/.xmonad/

stack exec -- xmonad --recompile
