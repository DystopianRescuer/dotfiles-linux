#!/bin/bash

MAC="50:F3:51:C8:76:2A"

# Desbloquear bluetooth en caso de que esté bloqueado por rfkill
rfkill unblock bluetooth

# Verificar si bluetooth está encendido
BT_POWER=$(bluetoothctl show | grep "Powered: yes")

if [[ -z "$BT_POWER" ]]; then
    bluetoothctl power on
    sleep 1  # darle chance a que encienda
fi


STATUS=$(bluetoothctl info "$MAC" | grep "Connected: yes")

if [[ -n "$STATUS" ]]; then
    bluetoothctl disconnect "$MAC"
    notify-send "Bluetooth" "🔇 AirPods desconectados"
else
    bluetoothctl connect "$MAC"
    notify-send "Bluetooth" "🎧 AirPods conectados"
fi

