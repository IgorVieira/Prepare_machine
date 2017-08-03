#!/bin/bash





package=$(zenity  --list  --text "Select the packages to be installed." --checklist  --column "Install" --column "Name" --column "Description"\
    FALSE "VSCode" "VSCode editor."\
    FALSE "Chrome" "A browser to your computer, phone and tablet."\
    FALSE "Git" "Git is a free and open source distributed version control system."\
    FALSE "nodejs" "Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."\
    FALSE "Bower" "Bower a package manager for the web (Requer NodeJS)"\
    FALSE "Ruby" "RVM e Ruby"\
    FALSE "Jekyll" "Transform your plain text into static websites and blogs."\
    FALSE "Spotify" "Spotify is a digital music service that gives you access to millions of songs."\
    FALSE "PostgreSQL" "The world's most advanced open source database.."\
    FALSE "MongoDB" "MongoDB for Debian/Ubuntu version 16.04"\
    FALSE "Heroku toolbelt" "Everything you need to get started using heroku"\
    --separator=":" --width=700 --height=700)


if [[ $package =~ "VSCode" ]]; then
  sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
  sudo apt-get update
  sudo apt-get install ubuntu-make
  umake web visual-studio-code
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


if [[ $package =~ "Ruby" ]]; then
    sudo apt-get update
    sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
    type rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    rbenv install -l
    rbenv install 2.3.1
    rbenv global 2.3.1
    echo "gem: --no-document" > ~/.gemrc
    gem install bundler
    gem install rails -v 5.1.2
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
 sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
 echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
 sudo apt-get update
 sudo apt-get install -y mongodb-org
fi

if [[ $package =~"Jekyll" ]]; then
  sudo apt-get install ruby ruby-dev make gcc nodejs
  sudo gem install jekyll -v 2.5.3
fi

if [[$package =~"Heroku toolbelt"]]; then
  wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
fi

sudo apt-get autoremove

zenity --info --title "setup Complete" --text "Successfully completed installation"
