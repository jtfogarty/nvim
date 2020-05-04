
## Install process

1. sudo useradd -m -s /bin/bash neovim  #linux only of course

2. sudo su - neovim

3. neovim
- Linux
	- wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz
		- tar -xzvf nvim-linux64.tar.gz
		- rm nvim-linux64.tar.gz
- OS X
	- wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-macos.tar.gzz
		- tar -xzvf nvim-macos.tar.gz
		- rm nvim-macos.tar.gz

4. Miniconda
- Linux 
	- wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
		- chmod +x Miniconda3-latest-Linux-x86_64.sh
		- ./Miniconda3-latest-Linux-x86_64.sh
    		- installing in ~/.miniconda
		- rm Miniconda3-latest-Linux-x86_64.sh
- OS X
    - wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
		- chmod +x Miniconda3-latest-MacOSX-x86_64.sh
		- ./Miniconda3-latest-MacOSX-x86_64.sh
    		- installing in ~/.miniconda
		- rm Miniconda3-latest-MacOSX-x86_64.sh

5. git clone https://github.com/ChristianChiarulli/nvim.git ~/.config/nvim

6. alias nano .profile
	- Linux
    	- nano .profile
		- alias vi='~/nvim-linux64/bin/nvim'
    - OS X
    	- nano .bash_profile
    	- alias vi='~/nvim-osx64/bin/nvim'

7. source .profile

8. conda create -n neovim python=3.8
	- conda activate neovim
	- pip install --no-cache-dir --upgrade --force-reinstall pynvim
    - pip install --no-cache-dir --upgrade --force-reinstall neovim-remote

9. execute `vi`
	- the first time neovim starts, plugins will be downloaded. 
    - after downloads complete, execute `:CocInstall coc-explorer`

