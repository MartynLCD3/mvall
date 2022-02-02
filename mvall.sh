#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
turquoise=$(tput setaf 6)
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

process() {
	if [ "$(ls --ignore=$location)" ]; then
		echo -e
		echo "${yellow}Moviendo contenido a: ${noColor}${green}$location${noColor}"
		mv $(ls --ignore=$location) $location 
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
}

moveAll() {
	if [ -d "$location" ]; then
		process
	else
		echo -e
		echo -ne "${red}El directorio ingresado no existe.${noColor} ¿Crear uno nuevo? [ ${green}si${noColor} / ${red}no${noColor} ] ▸ "
		read createNewDir
		case $createNewDir in
			si) 
				mkdir $location
				process ;;
			no)	
				sleep 1 
				mainMenu ;;
			*)
				sleep 1 
				mainMenu ;;
		esac
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
