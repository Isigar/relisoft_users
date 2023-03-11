# relisoft_users
### ESX users visible ID and name around you

Our discord with more scripts: https://discord.gg/F28PfsY

**Installation:**
1) Put resource directory into your resource folder
2) Start script with `ensure relisoft_users` after es_extended/qbcore
3) Setup config as fit you


**Config:**

`Config.NearPlayerTime = 500`
- time in miliseconds to check if players is in visible area, less = more lags

`Config.Command = 'users'`
- command that turn on/off this feature

<br>

- Allowed es_extended/qbcore groups which can use this command
```
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
```

`Config.TextSize = 1.2`
- size of 3D text

`Config.DrawDistance = 100`
- distance which will you see player name/id
