My vim Config
=============

This is just a git repo of my vimrc and some plugins.  I've moved to vundle to 
handle all of my plugins, which is added as a submodule in this repo.

Installation
------------

To clone be sure to use recursive to pull in vundle:

    git clone --recursive git@github.com:andrewrchambers/vimconf.git .vim
    
Then link to vimrc

    ln -s .vim/vimrc .vimrc
    
Then run vim, and in vim type

    :BundleInstall
    
This will pull in all of the bundles.  

Powerline
---------

There is one final step, since I use the powerline plugin for vim, we need to set up fonts (I use the powerline-fonts repo also).

I use Terminus, this is patched for powerline in the Terminus directory in the powerline-fonts repo.  We just need to run a few commands to set everything up.

    mkdir -p ~/.fonts
    cp -r .vim/bundle/powerline-fonts/Terminus ~/.fonts
    fc-cache -vf ~/.fonts
    
Note that if like me you use Ubuntu, you'll have to enable bitmap fonts with fontconfig, so

    sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
    
YouCompleteMe
-------------

I am also using the YCM plugin for code completion, and coupled with syntactic offers really useful syntax checking.

After pulling in all of the bundles, we have to compile it using

    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer
    
This will automatically download clang and do some magic to enable syntax checking while you code.

Other plugins
-------------

There are a few plugins in here which I have found around on the internet, many from Damian Conway, from the talk given in [this video](http://www.youtube.com/watch?v=aHm36-na4-4).  You can see his .vim [here](https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup)
