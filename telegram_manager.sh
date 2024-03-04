#!/bin/bash

url="https://telegram.org/dl/desktop/linux"
icon="https://static-00.iconduck.com/assets.00/telegram-icon-512x512-4sztjer8.png"
desktop_entry="[Desktop Entry]
Name=Telegram
StartupWMClass=telegram
Comment=Telegram instant messeger
GenericName=Internet Messenger
Exec=/usr/bin/telegram
Icon=/opt/Telegram/telegram.png
Type=Application
Categories=Network;InstantMessaging;
Path=/usr/bin"

download_app(){
	echo "Comenzando la descarga"
        sudo wget -O /tmp/telegram.tar.xz $url
	echo "Descarga finalizada"
}
install(){
	echo "Iniciando la instalacion"
	download_app
	sudo tar -xf /tmp/telegram.tar.xz -C /opt
	sudo ln -sf /opt/Telegram/Telegram /usr/bin/telegram
	sudo wget -O /opt/Telegram/telegram.png $icon
    sudo echo "$desktop_entry" >> ~/.local/share/applications/telegram.desktop
	echo "La instalacion ha finalizado"
	echo ""
}
update(){
	echo "Iniciando la actualizacion"
	sudo rm -rf /opt/Telegram
	download_app
	sudo tar -xf /tmp/telegram.tar.xz -C /opt
	echo "La actualizacion ha finalizado"
	echo ""
}
remove(){
	echo "Eliminando la aplicacion"
	sudo rm -rf /opt/Telegram
	sudo rm /usr/bin/telegram
	sudo rm ~/.local/share/applications/telegram.desktop
	echo "La aplicacion ha sido eliminada"
	echo ""
}
show_menu() {
    echo "Seleccione una opción:"
    echo "1) Instalar Telegram"
    echo "2) Actualizar Telegram"
    echo "3) Eliminar Telegram"
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
