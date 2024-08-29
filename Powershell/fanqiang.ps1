function Kaishi-Fanqiang {
    # Switch to the ChromeGo Folder
    # Make it is OneDriveConsumer instead of OneDrive,
    # since it is maybe of OneDriveCommercial which is another onedrive container.
    cd "$env:OneDriveConsumer\ChromeGo"
    # Set the window title
    $Host.UI.RawUI.WindowTitle = 'Fanqiang Console'
}