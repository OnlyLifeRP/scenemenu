fx_version 'cerulean'
games { 'gta5' }

author 'Thomthom160'
description 'Classic Scene Menu Script for traffic management. For ESX'
version '3.1.1'

lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua'
} 

client_scripts {
    'warmenu.lua',
    'client.lua'
}

server_script 'server.lua'