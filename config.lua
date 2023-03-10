Config = {}

-- Framework.ESX
-- Framework.QBCORE
Config.Framework = Framework.ESX

-- locales
Config.Locale = "en"

-- how often the refresh date is (in ms)
Config.NearPlayerTime = 500

-- command for the user ID to shpw
Config.Command = 'users'

-- size of the 3D Text
Config.TextSize = 1.2

-- what group can use this command?
Config.PermissionGroup = {
    ESX = {
        -- group system that used to work on numbers only
        [1] = {
            2, 3, 4, 5
        },
        -- group system that works on name
        [2] = {
            "helper", "mod", "admin", "superadmin",
        },
    },

    QBCore = {
        -- group system that works on ACE
        [1] = {
            "god", "admin", "mod",
        },
    }
}