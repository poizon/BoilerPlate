# BoilerPlate
Boilerplate project for Mojolicious

# Intro

# Run via carton 

carton exec morbo boiler_plate/script/boiler_plate -l "http://*:9000" -w boiler_plate/*

# Now available in browser

http://localhost:9000/


# If Carton not installed

cpanm Carton

# Systemd unit for hypnotoad

[Unit]
Description=BoilerPlate App
After=network.target
After=nginx.service
After=mysql.service

[Service]
Type=forking
PIDFile=/home/pavel/CRM/simple_crm/script/hypnotoad.pid
User=user
Group=user
ExecStart=carton exec /usr/local/bin/hypnotoad /home/user/boiler_plate/script/boiler_plate
ExecReload=carton exec /usr/local/bin/hypnotoad /home/user/boiler_plate/script/boiler_plate
KillMode=process

[Install]
WantedBy=multi-user.target


# Systemd unit for minion 

[Unit]
Description=MarketPlace application workers
After=mysql.service

[Service]
Type=simple
User=user
Group=user
ExecStart=carton exec /home/user/boiler_plate/script/boiler_plate minion worker -m production
KillMode=process

[Install]
WantedBy=multi-user.target
