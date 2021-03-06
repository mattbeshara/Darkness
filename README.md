# Darkness

Keep brightness levels consistent between built-in and external displays

![Demonstration GIF](Darkness.gif)

## How to use this app

1. Clone and build, or download a pre-built copy and unzip it.
2. Open the Privacy tab of the Security & Privacy pane of System
Preferences, and drag Darkness to the list of apps in Input Monitoring
and/or Accessibility (this varies depending on the version of macOS).
4. Run Darkness. You should see all displays dim slightly, which
indicates it's working.
5. Set the brightness level of all displays attached to your Mac to the
maximum level each is capable of.
6. Unless all displays have the same maximum brightness level, reduce
the brightness of the brighter displays to that of the dimmest
display. The idea is to have all displays at the same level of
brightness, and for that level of brightness to be only as bright as the
dimmest display is capable of, because this app can only make displays
appear darker.
7. Use the `F1` and `F2` keys (i.e. the brightness keys with the `fn`
key held down) to adjust the apparent brightness of all attached
displays consistently.

By default, this app has no visible user interface. To quit it, you can
activate the app by re-opening it from the Finder, and then press
command-q. Alternatively, you can use the shell by doing e.g.
`pkill Darkness`. To enable a Dock icon and menu bar with a Quit item,
change the value of the `LSUIElement` key in `Info.plist` to `false`.
