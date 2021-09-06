Config = {}

-- Menu config
Config.Align = 'right'

-- Triggers

Config.Triggers = { -- Change triggers :)
    LoadSkin = 'skinchanger:loadSkin',
    PlayerOutfit = 'esx_eden_clotheshop:getPlayerOutfit',
    GetPSkin = 'skinchanger:getSkin',
    OpenBossMenu = 'esx_society:openBossMenu'
}

Config.Gangs = {
    ['Poli Mafia'] = {
        Job = 'police',
        Society_Name = 'police',
        WashMoney = true,
        Armory = vec3(-18.0440, -1438.96, 31.101),
        SpawnCars = vec3(-23.4462, -1427.49, 30.657),
        SpawnVehicle = vec3(-25.0948, -1440.02, 30.653),
        DeleteCars = vec3(-25.0921, -1434.19, 30.653),
        Boss = vec3(-11.3260, -1428.31, 31.101),
        Cloakrooms = vec3(-9.20432, -1439.08, 31.101),
        Shop = vec3(-10.7427, -1433.49, 31.116),
        GangInfo = vec3(-18.0025, -1432.65, 31.101),
        Heading = 179.89,
        VehicleSpawnColor = {
            r = 189,
            g = 0,
            b = 255
        },
        Cars = {
            {label = 'Furia', model = 'furia'},
            {label = 'Itali RSX', model = 'italirsx'},
            {label = 'T20', model = 't20'},
            {label = 'Zentorno', model = 'zentorno'}
        },
        ItemShop = {
            {label = 'Bread', value = 'bread'},
            {label = 'Water', value = 'water'}
        },
        Weapons = {
            {label = 'Pistol', value = 'weapon_pistol'},
            {label = 'Combat Pistol', value = 'weapon_combatpistol'},
            {label = 'Assault SMG', value = 'weapon_assaultsmg'},
            {label = 'Assault Rifle', value = 'weapon_assaultrifle'},
            {label = 'Carbine Rifle', value = 'weapon_carbinerifle'},
            {label = 'Advanced Rifle', value = 'weapon_advancedrifle'},
            {label = 'Sniper Rifle', value = 'weapon_sniperrifle'}
        }
    }
    -- ['Cm Shop'] = {
    --     Job = 'taxi',
    --     Society_Name = 'taxi',
    --     WashMoney = true,
    --     Armory = vec3(-174.260, -1546.79, 35.127),
    --     SpawnCars = vec3(-160.381, -1545.35, 35.047),
    --     SpawnVehicle = vec3(-149.259, -1553.88, 34.693),
    --     DeleteCars = vec3(-152.686, -1556.73, 34.869),
    --     Boss = vec3(-184.111, -1539.66, 34.358),
    --     Cloakrooms = vec3(-179.746, -1534.72, 34.353),
    --     Shop = vec3(-174.839, -1529.05, 34.353),
    --     GangInfo = vec3(-167.762, -1534.92, 35.100),
    --     Heading = 318.55,
    --     VehicleSpawnColor = {
    --         r = 255,
    --         g = 0,
    --         b = 255
    --     },
    --     Cars = {
    --         {label = 'Furia', model = 'furia'},
    --         {label = 'Itali RSX', model = 'italirsx'},
    --         {label = 'T20', model = 't20'},
    --         {label = 'Zentorno', model = 'zentorno'}
    --     },
    --     ItemShop = {
    --         {label = 'Bread', value = 'bread'},
    --         {label = 'Water', value = 'water'}
    --     },
    --     Weapons = {
    --         {label = 'Pistol', value = 'weapon_pistol'},
    --         {label = 'Combat Pistol', value = 'weapon_combatpistol'},
    --         {label = 'Assault SMG', value = 'weapon_assaultsmg'},
    --         {label = 'Assault Rifle', value = 'weapon_assaultrifle'},
    --         {label = 'Carbine Rifle', value = 'weapon_carbinerifle'},
    --         {label = 'Advanced Rifle', value = 'weapon_advancedrifle'},
    --         {label = 'Sniper Rifle', value = 'weapon_sniperrifle'}
    --     }
    -- }
}