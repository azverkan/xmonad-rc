import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

import Control.Exception

import qualified Data.Map as M

main = do  
  finally (xmonad =<< xmobar myCfg) $ do
    putStrLn "XMonad exiting..."
    spawn "xfce4-session-logout -fl"
    putStrLn "XMonad exited cleanly."
  where
    cfg = ewmh desktopConfig
    myCfg = cfg {
      modMask = mod4Mask, -- Rebind Mod to the Windows key
      keys = myKeys <+> keys cfg,
      startupHook =
        spawn "xfce4-session" <+>
        startupHook cfg,
      handleEventHook = docksEventHook <+> handleEventHook cfg
      }
    myKeys (XConfig {modMask = modm}) = M.fromList $ [
      ((modm .|. shiftMask, xK_p), spawn "xfce4-appfinder"),
      ((modm, xK_x), spawn "emacs ~/.xmonad/xmonad.hs ~/.xmobarrc"),
      ((modm .|. shiftMask, xK_x), spawn "xfce4-settings-manager")
      ]
