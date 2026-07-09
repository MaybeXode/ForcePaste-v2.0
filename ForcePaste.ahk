#Requires AutoHotkey v2.0
#SingleInstance Force

; Configuration file path
global iniFile := A_ScriptDir "\Settings.ini"

; Default values
global hotkeyKey := "^+s"
global mode := "instant"
global delay := 10
global notifications := 0

; Creating a config with default values if it is missing
if !FileExist(iniFile) {
    IniWrite(hotkeyKey, iniFile, "Settings", "Hotkey")
    IniWrite(mode, iniFile, "Settings", "Mode")
    IniWrite(delay, iniFile, "Settings", "Delay")
    IniWrite(notifications, iniFile, "Settings", "Notifications")
} else {
    try hotkeyKey := IniRead(iniFile, "Settings", "Hotkey", "^+s")
    try mode := IniRead(iniFile, "Settings", "Mode", "instant")
    try delay := Integer(IniRead(iniFile, "Settings", "Delay", "10"))
    try notifications := Integer(IniRead(iniFile, "Settings", "Notifications", "0"))
}

; Setting up the tray icon and menu
A_IconTip := "ForcePaste"
try TraySetIcon("shell32.dll", 260) ; Notepad/clipboard icon

A_TrayMenu.Delete()
A_TrayMenu.Add("Mode: Instant", SetModeInstant)
A_TrayMenu.Add("Mode: Human", SetModeHuman)
A_TrayMenu.Add()

global delayMenu := Menu()
delayMenu.Add("5 ms", SetDelayValue)
delayMenu.Add("10 ms", SetDelayValue)
delayMenu.Add("20 ms", SetDelayValue)
delayMenu.Add("50 ms", SetDelayValue)
delayMenu.Add("100 ms", SetDelayValue)
A_TrayMenu.Add("Delay", delayMenu)
A_TrayMenu.Add()

A_TrayMenu.Add("Notifications", ToggleNotifications)
A_TrayMenu.Add("Suspend", ToggleSuspend)
A_TrayMenu.Add()

A_TrayMenu.Add("About", ShowAbout)
A_TrayMenu.Add("Restart", (*) => Reload())
A_TrayMenu.Add("Exit", (*) => ExitApp())

UpdateMenuState()

; Registering a hotkey
try {
    Hotkey(hotkeyKey, OnPasteHotkey)
} catch {
    MsgBox("Invalid hotkey in Settings.ini: " . hotkeyKey . "`nUsing Ctrl+Shift+S by default.", "ForcePaste - Error", "Iconx")
    hotkeyKey := "^+s"
    Hotkey(hotkeyKey, OnPasteHotkey)
}

; --- Updating the visual state of the menu ------------------

UpdateMenuState() {
    global mode, notifications, delay, delayMenu
    if (mode == "instant") {
        A_TrayMenu.Check("Mode: Instant")
        A_TrayMenu.Uncheck("Mode: Human")
        A_TrayMenu.Disable("Delay")
    } else {
        A_TrayMenu.Uncheck("Mode: Instant")
        A_TrayMenu.Check("Mode: Human")
        A_TrayMenu.Enable("Delay")
    }
    
    if (notifications) {
        A_TrayMenu.Check("Notifications")
    } else {
        A_TrayMenu.Uncheck("Notifications")
    }

    ; Resetting the check marks in the delay sub-menu
    for item in ["5 ms", "10 ms", "20 ms", "50 ms", "100 ms"] {
        delayMenu.Uncheck(item)
    }
    try {
        delayMenu.Check(delay . " ms")
    }
}

; --- Menu action handlers ------------------

SetModeInstant(itemName, itemPos, menu) {
    global mode
    mode := "instant"
    IniWrite(mode, iniFile, "Settings", "Mode")
    UpdateMenuState()
    ShowToolTip("Mode: Instant")
}

SetModeHuman(itemName, itemPos, menu) {
    global mode
    mode := "human"
    IniWrite(mode, iniFile, "Settings", "Mode")
    UpdateMenuState()
    ShowToolTip("Mode: Human")
}

SetDelayValue(itemName, itemPos, menu) {
    global delay
    delay := Integer(StrReplace(itemName, " ms", ""))
    IniWrite(delay, iniFile, "Settings", "Delay")
    UpdateMenuState()
    ShowToolTip("Delay: " . delay . " ms")
}

ToggleNotifications(itemName, itemPos, menu) {
    global notifications
    notifications := !notifications
    IniWrite(notifications ? "1" : "0", iniFile, "Settings", "Notifications")
    UpdateMenuState()
    ShowToolTip(notifications ? "Notifications enabled" : "Notifications disabled", true)
}

ToggleSuspend(itemName, itemPos, menu) {
    Suspend(-1)
    if A_IsSuspended {
        A_TrayMenu.Check("Suspend")
        ShowToolTip("Work suspended", true)
    } else {
        A_TrayMenu.Uncheck("Suspend")
        ShowToolTip("Work resumed", true)
    }
}

ShowAbout(itemName, itemPos, menu) {
    MsgBox("ForcePaste v2.0`n`nProgram to bypass restrictions on text insertion by simulating keyboard input.`n`nUse the hotkey (default Ctrl+Shift+S) to enter the contents of the clipboard.", "About ForcePaste", "Iconi")
}

; --- Logic for displaying pop-up hints ------------------

ShowToolTip(text, force := false) {
    if (!notifications && !force)
        return
    ToolTip(text)
    SetTimer(() => ToolTip(), -2000)
}

; --- Main paste logic ------------------

OnPasteHotkey(hotkeyName) {
    ; Waiting for the release of modifier keys to prevent sticking
    if GetKeyState("Ctrl", "P")
        KeyWait("Ctrl")
    if GetKeyState("Shift", "P")
        KeyWait("Shift")
    if GetKeyState("Alt", "P")
        KeyWait("Alt")
    if GetKeyState("LWin", "P")
        KeyWait("LWin")
    if GetKeyState("RWin", "P")
        KeyWait("RWin")

    text := A_Clipboard
    if (text == "") {
        ShowToolTip("Clipboard is empty!")
        return
    }

    ShowToolTip("Pasting...")
    
    ; Programmatic reset of modifier states before sending text
    Send("{Ctrl up}{Shift up}{Alt up}{LWin up}{RWin up}")

    if (mode == "instant") {
        SendText(text)
    } else {
        SetKeyDelay(delay)
        SendEvent("{Text}" . text)
    }
}