# ForcePaste 🚀

[English](#english) | [Русский](#русский)

---

## English

**ForcePaste** is a lightweight Windows utility written in **AutoHotkey v2** designed to bypass restrictions that block text pasting from the clipboard (such as on certain websites, exams, remote desktop environments, or terminal windows).

It works by intercepting a custom hotkey, reading the text from your clipboard, and simulating rapid keyboard typing character-by-character or instantly.

### Features
*   **Bypass Paste Blocks**: Works in fields where standard Ctrl+V is disabled.
*   **Two Paste Modes**:
    *   **Instant** (`SendInput`): Blazing fast instant typing.
    *   **Human-like** (`SendEvent`): Emulates real typing with custom milliseconds delay between keystrokes (perfect for remote terminals, virtualization, or protected environments).
*   **Interactive Tray Menu**: Easily toggle modes, adjust key delay, toggle notifications, or pause the script right from the system tray.
*   **Unicode/Layout Friendly**: Uses modern AutoHotkey `{Text}` sending mode, ensuring Cyrillic and special characters are typed correctly regardless of active keyboard layout.
*   **Configurable**: Hotkey and all settings can be customized in a clean `Settings.ini` file.

### Installation
*   **Option 1 (Precompiled exe)**: Simply run `ForcePaste.exe` directly. No installation required.
*   **Option 2 (Source script)**: Download and install [AutoHotkey v2](https://www.autohotkey.com/) and run `ForcePaste.ahk`.
*   (Optional) Customize settings in `Settings.ini`.

### Configuration (`Settings.ini`)
*   `Hotkey`: Custom trigger key (Default: `^+s` for `Ctrl+Shift+S`).
*   `Mode`: Set to `instant` or `human`.
*   `Delay`: Character delay in milliseconds (only for `human` mode).
*   `Notifications`: Set to `1` (enabled) or `0` (disabled) to control tooltip feedback.

---

## Русский

**ForcePaste** — это легковесная утилита для Windows, написанная на **AutoHotkey v2**, предназначенная для обхода ограничений на вставку текста из буфера обмена (на сайтах, в формах авторизации, терминалах, прокторинг-системах или удаленных рабочих столах).

Скрипт перехватывает нажатие горячей клавиши, считывает текст из буфера обмена и имитирует его быстрый ввод с клавиатуры.

### Особенности
*   **Обход блокировок вставки**: Работает везде, где заблокировано стандартное сочетание Ctrl+V.
*   **Два режима ввода**:
    *   **Мгновенный** (`SendInput`): Моментальная вставка текста.
    *   **Имитация ввода** (`SendEvent`): Посимвольный ввод с настраиваемой задержкой (идеально для виртуальных машин, терминалов и систем с защитой от мгновенного ввода).
*   **Интерактивное меню в трее**: Переключение режимов, настройка задержки нажатий, включение/выключение уведомлений и приостановка работы прямо из панели задач.
*   **Корректная работа с раскладкой**: Использует современный режим `{Text}`, который вводит кириллицу и спецсимволы без ошибок, независимо от текущей раскладки клавиатуры.
*   **Конфигурируемость**: Все настройки сохраняются в удобном файле `Settings.ini`.

### Инструкция по запуску
*   **Вариант 1 (Скомпилированный .exe)**: Просто запустите готовый исполняемый файл `ForcePaste.exe` (установка AutoHotkey не требуется).
*   **Вариант 2 (AHK-скрипт)**: Установите [AutoHotkey v2](https://www.autohotkey.com/) и запустите исходный скрипт `ForcePaste.ahk`.
*   (Опционально) Настройте параметры в файле `Settings.ini`.

### Параметры конфигурации (`Settings.ini`)
*   `Hotkey`: Горячая клавиша активации (По умолчанию: `^+s` для `Ctrl+Shift+S`).
*   `Mode`: Режим вставки (`instant` или `human`).
*   `Delay`: Задержка между символами в миллисекундах (только для режима `human`).
*   `Notifications`: Включение/выключение уведомлений около курсора (`1` — включены, `0` — выключены).

---

### License / Лицензия
Licensed under the [MIT License](LICENSE).
