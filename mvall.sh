#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
turquoise=$(tput setaf 6)
gray=$(tput setaf 7)
noColor=$(tput sgr0)

closeProgram() {
	clear
	tput bold
	tput cup 1 0
	echo "${yellow}
	██████╗ ██╗   ██╗███████╗██╗
	██╔══██╗╚██╗ ██╔╝██╔════╝██║
  	██████╔╝ ╚████╔╝ █████╗  ██║
	██╔══██╗  ╚██╔╝  ██╔══╝  ╚═╝
	██████╔╝   ██║   ███████╗██╗
	╚═════╝    ╚═╝   ╚══════╝╚═╝                 
	${noColor}"
}

moveAll() {
	if [ -d "$location" ]; then
		if [ "$(ls --ignore=$location)" ]; then
			echo -e
			echo "${yellow}Moviendo contenido a: ${noColor}${green}$location${noColor}"
			mv $(ls --ignore=$location) $location > /dev/null 2>&1 
		       	sleep 2
			echo -e
			tput bold
			echo "✅ ${green}Documentos movidos correctamente.${noColor}"
			sleep 2
			closeProgram	
		else
			echo -e
			tput bold
			echo "${red}No existen ficheros ni directorios para mover.${noColor}"
			sleep 2	
		       	closeProgram
		fi	
	else
		echo -e
		echo "${red}El directorio ingresado no existe${noColor}"
		sleep 1 
		mainMenu
	fi
}

mainMenu() {
	clear
	tput civis
	tput bold
	tput cup 1 0
	echo "${yellow}
      	███╗   ███╗██╗   ██╗ █████╗ ██╗     ██╗     
      	████╗ ████║██║   ██║██╔══██╗██║     ██║     
      	██╔████╔██║██║   ██║███████║██║     ██║     
      	██║╚██╔╝██║╚██╗ ██╔╝██╔══██║██║     ██║     
      	██║ ╚═╝ ██║ ╚████╔╝ ██║  ██║███████╗███████╗
      	╚═╝     ╚═╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚══════╝
     	${noColor}"
	echo -ne "Indique el nombre del directorio ${turquoise}[ puede especificar ruta ]${noColor} ▸ "
	read location
	echo -ne "¿Confirmar? [ ${green}si${noColor} / ${red}no${noColor} ] ▸ "
	read confirm
	case "$confirm" in 
		si) moveAll ;;
		no) echo -ne "¿Continuar? [ ${green}si${noColor} / ${red}no${noColor} ] ▸ "
		    read continueScript
		    case $continueScript in
			si) mainMenu ;;
			no) closeProgram ;;
			*) closeProgram ;;
		    esac
		;;
		*) closeProgram ;;
	esac
}

mainMenu
