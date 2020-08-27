# relisoft_users
### ESX users visible ID and name around you

Our discord with more scripts: https://discord.gg/F28PfsY 

**Dependencies:**
- es_extended

**Installation:**
1) Put resource directory into your resource folder
2) Start script with `ensure relisoft_users` after es_extended
3) Setup config as fit you


**Config:**

`Config.NearPlayerTime = 500`
- time in miliseconds to check if players is in visible area, less = more lags

`Config.Command = 'users'`
- command that turn on/off this feature

`Config.AllowedGroups = {
    'mod',
    'admin',
    'superadmin'
}`
- Allowed es_extended groups which can use this command

`Config.TextSize = 1.2`
- size of 3D text

`Config.DrawDistance = 100`
- distance which will you see player name/id
