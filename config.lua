Config = {

    Trigger = 'esx:getSharedObject',

    Titre = "Armurerie",

    NomServeur = "Los Santos", -- Nom du serveur

    ArmesEnItem = false, -- Si vous souhaitez que les armes soit en item = true sinon = false
    PPA = true, -- Si vous souhaitez activez le système de PPA = true sinon = false
    Accessoires = true, -- Si vous souhaitez activez le système d'accessoires = true sinon = false

    BuyPPA = false, -- Si vous souhaitez activez le système d'achat de PPA = true sinon = false
    PrixPPA = 50000, -- Prix du PPA

    MarkerTourne = true, -- Si vous souhaitez activez le marker qui tourne = true sinon = false
    MarkerSaute = false, -- Si vous souhaitez activez le marker qui saute = true sinon = false

    CouleurMenu = {
        R = 255,
        G = 0,
        B = 0,
        Opacity = 70,
    },

    ArmureriePosition = {
        {pos = vector3(21.13967, -1106.724, 29.79704)},
        {pos = vector3(810.25, -2157.60, 29.62)},
        {pos = vector3(1693.44, 3760.16, 34.71)},
        {pos = vector3(-330.24, 6083.88, 31.45)},
        {pos = vector3(252.63, -50.00, 69.94)},
        {pos = vector3(2567.69, 294.38, 108.73)},
        {pos = vector3(-1117.58, 2698.61, 18.55)},
        {pos = vector3(842.44, -1033.42, 28.19)},
        {pos = vector3(-1305.732, -394.0781, 36.69576)},
    },
    
    ArmesBlanches = {
        {
            nom = "Couteau",
            armes = "WEAPON_KNIFE", -- si ArmesEnItem = true alors mettre le nom de l'item (exemple: "pistol")
            prix = 500,
        },
        {
            nom = "Cran d'arrêt",
            armes = "WEAPON_NIGHTSTICK",
            prix = 50,
        },
    },

    ArmesLourdes = {
        {
            nom = "AK 47",
            armes = "WEAPON_ASSAULTRIFLE", -- si ArmesEnItem = true alors mettre le nom de l'item (exemple: "pistol")
            prix = 5000,
        },
        {
            nom = "M4",
            armes = "WEAPON_CARBINERIFLE",
            prix = 10000,
        },
    },

    Items = {
        {
            nom = "Chargeur",
            item = "clip",
            prix = 25,
        },
        {
            nom = "Gilet Pare-Balles",
            item = "bulletproof",
            prix = 500,
        },
        {
            nom = "Gilet Pare-Balles",
            item = "bread",
            prix = 500,
        },
    },

    Logs = {
        ArmesLourdes = {
            Webhook = "https://discord.com/api/webhooks/1092046034005409853/0tobUjA13J-RvcUPljHBy5eYSfJKUm8EJFYoEBucjI36GFPjOnYfxkCU2vY5w0WEiQgG"
        },
        ArmesBlanches = {
            Webhook = "https://discord.com/api/webhooks/1092046034005409853/0tobUjA13J-RvcUPljHBy5eYSfJKUm8EJFYoEBucjI36GFPjOnYfxkCU2vY5w0WEiQgG"
        },
    },
}
