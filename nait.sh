#!/bin/bash

#2019-11-26 : v1.5 : correction de l'ordre d'installation des dépendances.
#2019-11-25 : v1.3 : ajout dépôt pour install git + clé

if [[ $1 == "" ]]; then

	echo
    echo " Usage: "$0" [-git] installation de NextDom via GitClone" 
    echo " Usage: "$0" [-apt] installation de NextDom via un paquet Deb"   	
	echo " 						[  ] installation depuis le dépôt officel"
    echo " 						[-d] installation du paquet depuis le dépôt dev"  
    echo "						[-n] installation du paquet depuis le dépôt nightly" 
    echo
fi
			
if [[ $1 == "-git" ]]; then
	rm -R /var/log/nextdom* 2>/dev/null
	echo "Dossier /var/log/nextdom* supprimé"

	rm -R /var/lib/nextdom* 2>/dev/null
	echo "Dossier /var/lib/nextdom* supprimé"

	rm -R /var/www/html* 2>/dev/null
	echo "Dossier /var/www/html* supprimé"

	rm -R /usr/share/nextdom* 2>/dev/null
	echo "Dossier /usr/share/nextdom* supprimé"

	rm -R /tmp/nextdom/* 2>/dev/null

	apt purge -y nextdom
	apt autoremove -y

	echo "Création dossier HTML"
	mkdir /var/www/html 2>/dev/null
			echo "installation GIT"
			apt update
			apt install -y software-properties-common gnupg wget ca-certificates
			add-apt-repository non-free
			wget -qO -  http://debian.nextdom.org/debian/nextdom.gpg.key  | apt-key add -
			echo "deb  http://debian.nextdom.org/debian  nextdom main" >/etc/apt/sources.list.d/nextdom.list
			apt update
			apt -y install nextdom-common
			cd /var/www/html/
			git clone  https://github.com/NextDom/nextdom-core  .
			git config core.fileMode false
			./install/postinst
			
fi

if [[ $1 == "-apt" ]]; then
	rm -R /var/log/nextdom* 2>/dev/null
	echo "Dossier /var/log/nextdom* supprimé"

	rm -R /var/lib/nextdom* 2>/dev/null
	echo "Dossier /var/lib/nextdom* supprimé"

	rm -R /var/www/html* 2>/dev/null
	echo "Dossier /var/www/html* supprimé"

	rm -R /usr/share/nextdom* 2>/dev/null
	echo "Dossier /usr/share/nextdom* supprimé"

	rm -R /tmp/nextdom/* 2>/dev/null

	apt purge -y nextdom
	apt autoremove -y

	echo "Création dossier HTML"
			mkdir /var/www/html 2>/dev/null
			apt update
			apt install -y software-properties-common gnupg wget ca-certificates
			add-apt-repository non-free
			wget -qO -  http://debian.nextdom.org/debian/nextdom.gpg.key  | apt-key add -
			echo "deb  http://debian.nextdom.org/debian  nextdom main" >/etc/apt/sources.list.d/nextdom.list
			apt update
			apt -y install nextdom-common
			
		if [ $2 == "" ]; then
			echo " installation de NextDom via APT sur le dépôts officiel"
			echo "deb  http://debian.nextdom.org/debian  nextdom main" >/etc/apt/sources.list.d/nextdom.list
			apt update
			apt install -y nextdom
			
		fi
		
		if [ $2 == "-d" ]; then
			echo " installation de NextDom via APT sur le dépôts dev"
			echo "deb  http://debian-dev.nextdom.org/debian  nextdom main" >/etc/apt/sources.list.d/nextdom.list
			apt update
			apt install -y nextdom
			
		fi
		
		if [ $2 == "-n" ]; then
			echo " installation de NextDom via APT sur le dépôts dev"
			echo "deb  http://debian-nightly.nextdom.org/debian  nextdom main" >/etc/apt/sources.list.d/nextdom.list
			apt update
			apt install -y nextdom
			
		fi
fi

if [[ $1 == "-gitbr" ]]; then
	rm -R /var/log/nextdom* 2>/dev/null
	echo "Dossier /var/log/nextdom* supprimé"

	rm -R /var/lib/nextdom* 2>/dev/null
	echo "Dossier /var/lib/nextdom* supprimé"

	rm -R /var/www/html* 2>/dev/null
	echo "Dossier /var/www/html* supprimé"

	rm -R /usr/share/nextdom* 2>/dev/null
	echo "Dossier /usr/share/nextdom* supprimé"

	rm -R /tmp/nextdom/* 2>/dev/null

	apt purge -y nextdom
	apt autoremove -y
	echo "Création dossier HTML"
	mkdir /var/www/html 2>/dev/null
			echo "Reinstallation de Netxdom"
			apt update
			apt install -y software-properties-common gnupg wget ca-certificates
			add-apt-repository non-free
			wget -qO -  http://debian.nextdom.org/debian/nextdom.gpg.key  | apt-key add -
			echo "deb  http://debian.nextdom.org/debian  nextdom main" >/etc/apt/sources.list.d/nextdom.list
			apt update
			apt -y install nextdom-common
			cd /var/www/html
			git clone  https://github.com/NextDom/nextdom-core  .
			git config core.fileMode false
			echo "passage à la branche " $2
			git checkout $2
			git reset --hard origin/$2
			./install/postinst
fi

if [[ $1 == "-?" ]] || [[ $1 == "-help" ]]; then
			echo ""
			echo "N A I T v1.1"
			echo ""
			echo "Nextdom Auto Installer Tool"
			echo "Developed by the Great Master of Nextdom tEsTs, alias the great @GiDom"
			echo "with a little help from the appreciative padawan tester, @vinceg77"
			echo ""
			echo "Utilisation : nait [OPTION]"
			echo ""
			echo "	-apt		: Installation via apt, dépôt officiel"	
			echo "		-apt -n		: version nightly"
			echo "		-apt -d		: version dépôt develop"
			echo ""
			echo "	-git		: Installation via git"
			echo ""
			echo "	-gitbr NOM_DE_LA_BRANCHE	: Changement de branche git"
			echo ""
			echo "	-? ou -help	: afficher l'aide et quitter"					
fi

exit 
