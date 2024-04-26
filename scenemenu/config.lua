
Config = {}
Config.ActivationCommand = "scenemenu" -- The command used to open the menu if ActivationMode is 'Command'. (Automatically adds /)

-- Add/Remove/Change the options for radius and speed when setting a zone below.
Config.SpeedZone = {
    Radius = {'25', '50', '75', '100', '125', '150', '175', '200'},
    Speed = {'0', '5', '10', '15', '20', '25', '30', '35', '40', '45', '50'},
}

-- The message that shows in chat when speed zone is placed. Set to false to disable.
Config.TrafficAlert = false

Config.autorizedJobs = {
    ['police'] = 0,
    ['bcso'] = 0,
    ['gruppe6'] = 0
}