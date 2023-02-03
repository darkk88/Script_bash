#!/bin/bash

clear
echo -e "\e[34mD\e[32mA\e[34mR\e[32mK\e[0m"
echo -e "\e[34m   ___  _   _  ____  _  __\e[0m"
echo -e "\e[32m  / _ \| \ | |/ ___|| |/ /\e[0m"
echo -e "\e[34m | | | |  \| |\___ \| ' / \e[0m"
echo -e "\e[32m | |_| | |\  | ___) | . \  \e[0m"
echo -e "\e[34m  \___/|_| \_||____/|_|\_\ \e[0m"
echo ""
echo -e "\e[36mAuthor :\e[0m Romain Heuraux"
echo -e "\e[36mWebsite :\e[0m Non-fungible-testicunix.com"
echo ""

# Boucle pour afficher le menu et collecter les options de l'utilisateur
while true; do

  echo -e "
  \e[36m1) Adresse IP\e[0m
  \e[33m2) Adresse MAC\e[0m
  \e[35m3) Ports ouverts\e[0m
  \e[34m4) Espace libre sur le disque dur\e[0m
  \e[32m5) Version du système\e[0m
  \e[31m6) Liste des programmes installés\e[0m
  \e[33m7) Liste des utilisateurs et mots de passe\e[0m
  \e[36m8) Afficher l'adresse IP publique\e[0m
  \e[36m1) Quitter\e[0m

"
  # Collecte de l'option de l'utilisateur
  read -p "Choisissez une option : " option
 # Sélection de l'option avec un switch
  case $option in
    1)
      # Récupération de l'adresse IP
      ip=$(hostname -I)
      echo -e "\e[32mAdresse IP : $ip\e[0m"
read -p "Appuyez sur Entrée pour continuer..."
      ;;
    2)
      # Récupération de l'adresse MAC
      mac=$(ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
      echo -e "\e[32mAdresse MAC : $mac\e[0m"
read -p "Appuyez sur Entrée pour continuer..."
      ;;
    3)
      # Récupération des ports ouverts
      ports=$(sudo lsof -i -P -n | grep LISTEN)
      echo -e "\e[32mPorts ouverts :\n$ports\e[0m"
read -p "Appuyez sur Entrée pour continuer..."
      ;;
    4)
      # Récupération de l'espace libre sur le disque dur
      disk=$(df -h | awk '$NF=="/"{printf "Disque dur: %d Go / %d Go\n", $3,$2}')
      echo -e "\e[32m$disk\e[0m"
read -p "Appuyez sur Entrée pour continuer..."
      ;;
    5)
      # Récupération de la version du système
      version=$(lsb_release -d)
      echo -e "\e[32m$version\e[0m"
read -p "Appuyez sur Entrée pour continuer..."
      ;;
    6)
      # Récupération de la liste des programmes installés
      programs=$(dpkg --get-selections)
      echo -e "\e[32mListe des programmes installés :\n$programs\e[0m"
read -p "Appuyez sur Entrée pour continuer..."
      ;;
    7)
      # Récupération de la liste des utilisateurs et mots de passe
        echo -e "\e[36mListe des utilisateurs et mots de passe :\e[0m"
      while IFS=: read user pass; do
        echo "Utilisateur : $user / Mot de passe : $pass"
      done < <(cat /etc/shadow | awk -F: '{printf "%s:%s\n", $1, $2}')
      read -p "Appuyez sur Entrée pour continuer..."
      ;;
    8)
      # Afficher l'adresse IP publique
      echo -e "\e[36mAdresse IP publique :\e[0m"
      curl -s http://checkip.dyndns.org | awk -F':' '{print $2}' | awk -F'<' '{print $1}'
      read -p "Appuyez sur Entrée pour continuer..."
      ;;
    9)
      # Option pour quitter
      echo -e "\e[32mAu revoir !\e[0m"
      exit 0
      ;;
    *)
      # Message d'erreur pour les options non valides
      echo -e "\e[31mOption non valide, veuillez réessayer.\e[0m"
      ;;
  esac
done
