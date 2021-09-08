fx_version "cerulean"
game "gta5"

name "c-gangs"
description "A simple gang script"
author "Carlooss"
version "1"

client_scripts {
	'@es_extended/locale.lua',
	"Client/Modules/*.lua",
	"Config/*.lua",
	"Client/*.lua"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    	'@es_extended/locale.lua',
	"Config/*.lua",
	"Server/*.lua"
}

dependency {
	'fivem-appearance'
}
