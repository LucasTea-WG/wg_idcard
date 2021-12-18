fx_version 'bodacious'
game 'gta5'

description "An HUD for jsfour license by LucasTEA"

client_scripts{
    "c_main.lua"    
}

server_scripts{
    "s_main.lua"
}

ui_page "html/index.html"

files{
    "html/index.html",
    "html/style.css",
    "html/main.js",
    "html/img/*.png"
}

dependencies {
	'es_extended',
	'esx_license',
	'jsfour-idcard'
}