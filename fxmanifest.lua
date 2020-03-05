fx_version 'adamant'
games { 'gta5' }

client_scripts {
	'core/client/cl_functions.lua',
	'core/client/cl_ply.lua',
	'core/client/cl_locations.lua',
	'_configs/cfg_general.lua'
}

server_scripts {
	'@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
	'core/server/sv_ply.lua',
	'core/server/sv_locations.lua',
	'_configs/cfg_general.lua'
}
