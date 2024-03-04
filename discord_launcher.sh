#!/bin/bash

url="https://discordapp.com/api/download?platform=linux&format=tar.gz"
desktop_entry="[Desktop Entry]
Name=Discord
StartupWMClass=discord
Comment=All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.
GenericName=Internet Messenger
Exec=/usr/bin/Discord
Icon=/opt/Discord/discord.png
Type=Application
Categories=Network;InstantMessaging;
Path=/usr/bin"

download_app(){
	echo "Comenzando la descarga"
        sudo wget -O /tmp/discord.tar.gz $url
	echo "Descarga finalizada"
}
install(){
	echo "Iniciando la instalacion"
	download_app
	sudo tar -xvzf /tmp/discord.tar.gz -C /opt
	sudo ln -sf /opt/Discord/Discord /usr/bin/Discord
        sudo echo "$desktop_entry" >> ~/.local/share/applications/discord.desktop
	echo "La instalacion ha finalizado"
	echo ""
}
update(){
	echo "Iniciando la actualizacion"
	sudo rm -rf /opt/Discord
	download_app
	sudo tar -xvzf /tmp/discord.tar.gz -C /opt
	echo "La actualizacion ha finalizado"
	echo ""
}
remove(){
	echo "Eliminando la aplicacion"
	sudo rm -r ~/.config/discord
	sudo rm -rf /opt/Discord
	sudo rm /usr/bin/Discord
	sudo rm ~/.local/share/applications/discord.desktop
	echo "La aplicacion ha sido eliminada"
	echo ""
}
show_menu() {
    echo "Seleccione una opción:"
    echo "1) Instalar Discord"
    echo "2) Actualizar Discord"
    echo "3) Eliminar Discord"
    echo "4) Salir"

    read -p "Opción: " option
    case $option in
        1) install ;;
        2) update ;;
        3) remove ;;
        4) exit ;;
        *) echo "Opción inválida. Por favor, seleccione una opción válida." ;;
    esac
}

# Bucle principal del programa
while true; do
    show_menu
done
