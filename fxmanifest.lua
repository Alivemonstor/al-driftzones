fx_version "cerulean"
game "gta5"

lua54 "yes"

client_scripts {
  'client/*.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua'
}

shared_scripts {
  'config.lua',
}
