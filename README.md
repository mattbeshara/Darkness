# Darkness

Keep brightness levels consistent between built-in and external displays

## How to use this app

1. Build, or download a pre-built copy.
2. Run.
3. Grant `Input Monitoring` and/or `Accessibility` permissions when
prompted to do so.
4. Run again.
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

By default, this app has no visible user interface, and to quit it you
have to use the shell by doing e.g. `pkill Darkness`. To enable a Dock
icon and menu bar with a Quit item, change the value of the
`LSUIElement` key in the `Info.plist` to `false`.

If you’re building your own copy and the app `fatalError`s with the
message "Failed to create tap", try running the app again after
dragging it into the list of apps in the Privacy preference pane, even
if it's there already.
