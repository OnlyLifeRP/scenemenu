
Config = {}
Config.ActivationCommand = "scenemenu" -- The command used to open the menu if ActivationMode is 'Command'. (Automatically adds /)


--[[ OBJECT CONFIGURATION! --

This is the configuration section to add objects to the object menu and remove existing ones too!

To add an object, simply follow the below template and add it between the dashed lines below...

 { Displayname = "OBJECTNAME", Object = "SPAWNCODE" },

]]--
Config.Objects = {
    { Displayname = "Police Barrier", Object = "prop_barrier_work05" },
    { Displayname = "Big Cone", Object = "prop_roadcone01a" },
    { Displayname = "Small Cone", Object = "prop_roadcone02b" },
    { Displayname = "Gazebo", Object = "prop_gazebo_02" },
    { Displayname = "Scene Lights", Object = "prop_worklight_03b" },
}

-- Add/Remove/Change the options for radius and speed when setting a zone below.
Config.SpeedZone = {
    Radius = {'25', '50', '75', '100', '125', '150', '175', '200'},
    Speed = {'0', '5', '10', '15', '20', '25', '30', '35', '40', '45', '50'},
}

-- The message that shows in chat when speed zone is placed. Set to false to disable.
Config.TrafficAlert = false


Config.autorizedJobs = {
    'police',
    'bcso',
    'gruppe6'
}