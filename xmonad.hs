import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Prompt
import XMonad.Prompt.Shell

import Graphics.X11.ExtraTypes.XF86

import Control.Exception
import System.IO

import qualified Data.Map as M

main = do
  xmonad =<< xmobar myCfg
  where
    cfg = ewmh desktopConfig
    myCfg = cfg {
      modMask = mod4Mask, -- Rebind Mod to the Windows key
      terminal = "urxvt",
      keys = myKeys <+> keys cfg,
      startupHook = do
          startupHook cfg
          spawn "~/.xmonad/startup.sh",
      handleEventHook = docksEventHook <+> handleEventHook cfg}
    myKeys (XConfig {modMask = modm}) = M.fromList $ [
      ((modm, xK_p), shellPrompt def),
      ((modm, xK_x), spawn $ unwords [
          "emacs",
          "~/.xmonad/xmonad.hs",
          "~/.xmobarrc",
          "~/.stalonetrayrc",
          "~/.xmonad/startup.sh"]),
      ((modm, xK_w), spawn "google-chrome"),
      ((modm, xK_z), spawn "xset dpms force off"),
      ((modm, xK_v), spawn "alsamixergui"),
      ((0 , xF86XK_AudioRaiseVolume), spawn "amixer -q sset Master 2%+"),
      ((0 , xF86XK_AudioLowerVolume), spawn "amixer -q sset Master 2%-"),
      ((0 , xF86XK_AudioMute), spawn "amixer -q sset Master toggle"),
      ((modm .|. shiftMask, xK_x), spawn "xfce4-settings-manager")]
