// Enable userChrome.css loading
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Force light theme
user_pref("extensions.activeThemeID", "firefox-compact-light@mozilla.org");

// Force light color scheme for web content and UI
user_pref("layout.css.prefers-color-scheme.content-override", 1);
user_pref("ui.systemUsesDarkTheme", 0);

// Disable Zen's automatic dark theme detection
user_pref("browser.theme.content-theme", 1);
user_pref("browser.theme.toolbar-theme", 1);
