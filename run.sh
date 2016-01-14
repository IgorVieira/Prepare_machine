#!/bin/bash





package=$(zenity  --list  --text "Select the packages to be installed." --checklist  --column "Install" --column "Name" --column "Description"\
    FALSE "Atom" "A hackable text editor for the 21st Century."\
    FALSE "Chrome" "A browser to your computer, phone and tablet."\
    FALSE "Git" "Git is a free and open source distributed version control system."\
    FALSE "nodejs" "Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."\
    FALSE "Bower" "Bower a package manager for the web (Requer NodeJS)"\
    FALSE "Ruby" "RVM e Ruby"\
    FALSE "Jekyll" "Transform your plain text into static websites and blogs."\
    FALSE "Spotify" "Spotify is a digital music service that gives you access to millions of songs."\
    FALSE "PostgreSQL" "The world's most advanced open source database.."\
    FALSE "MongoDB" "A GIANT LEAP"\
    FALSE "Heroku toolbelt" "Everything you need to get started using heroku"\
    --separator=":" --width=700 --height=700)


if [[ $package =~ "Atom" ]]; then
  sudo add-apt-repository ppa:webupd8team/atom
  sudo apt-get update
  sudo apt-get install atom
fi


if [[ $package =~ "Chrome" ]]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
  sudo apt-get update
  sudo apt-get install -y google-chrome-stable
fi

if [[ $package =~ "Git"]]; then
  sudo apt-get install -y git
fi



if [[ $package =~ "node" ]]; then
  sudo apt-get install -y curl

  curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
  sudo apt-get update
  sudo apt-get install -y nodejs
  echo prefix = ~/.node >> ~/.npmrc
  echo 'export PATH=$HOME/.node/bin:$PATH' >> ~/.bashrc
fi

if [[ $package =~ "Bower" ]]; then
  sudo npm install -g  bower
fi

if [[ $package =~ "Ruby" ]]; then
    sudo apt-get install -y curl
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable
fi


if [[ $package =~ "Spotify" ]]; then
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update
  sudo apt-get install -y spotify-client
fi

if [[ $package =~ "PostgreSQL" ]]; then
  sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
  wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install postgresql-common
  sudo apt-get install postgresql-9.3 libpq-dev
fi

if [[ $package =~ "MongoDB" ]]; then
 sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
 echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
 sudo apt-get update
 sudo apt-get install mongodb-org
fi

if [[ $package =~"Jekyll" ]]; then
  sudo apt-get install ruby ruby-dev make gcc nodejs
  sudo gem install jekyll -v 2.5.3
fi

if [[$package =~"Heroku toolbelt"]]; then
  wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi

sudo apt-get autoremove

zenity --info --title "setup Complete" --text "Successfully completed installation"
