yes | sudo apt-get update && yes | sudo apt-get upgrade

# Install Dependencies:
yes | sudo apt-get install ruby-full build-essential zlib1g-dev

# Add environement variables to ~/.bashrc to configure gem installation path:
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Install Jekyll:
sudo gem install jekyll bundler

# Install the rest of the gems in the project folder:
cd /Documents
mkdir jacobortiz.dev
cd /jacobortiz.dev
sudo bundle install

# Serve application
sudo bundle exec jekyll serve --host 0.0.0.0

# Open Link
xdg-open http://0.0.0.0:4000/
