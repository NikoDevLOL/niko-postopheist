shared_script '@theftrp_shield/ai_module_fg-obfuscated.lua'
shared_script '@theftrp_shield/ai_module_fg-obfuscated.js'
fx_version 'cerulean'
game 'gta5'
 
lua54 'yes'
 
shared_scripts {
    'config.lua',
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
}
 
client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}