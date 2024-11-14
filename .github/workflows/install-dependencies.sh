
set -euo pipefail
sudo apt install -y wget

sudo apt-get update
sudo apt-get install wget
wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget https://packages.microsoft.com/config/debian/9/prod.list
sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list

sudo apt-get install -y apt-transport-https && \
sudo apt-get update && \
sudo apt-get install -y dotnet-sdk-8.0
echo "✅ dotnet installed"

sudo apt-get install -yqq kubectl git
echo "✅ kubectl installed"

wget https://golang.org/dl/go1.19.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz
echo 'export GOPATH=$HOME/go' >> ~/.profile
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.profile
source ~/.profile
echo "✅ golang installed"


sudo apt install -y build-essential

go install github.com/google/addlicense@latest
sudo ln -s $HOME/go/bin/addlicense /bin

sudo apt install -y build-essential

curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
chmod +x skaffold && \
sudo mv skaffold /usr/local/bin
echo "✅ skaffold installed"

sudo apt install -yqq apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
sudo apt-get update && \
sudo apt-get install -yqq docker-ce && \
sudo usermod -aG docker ${USER}
echo "✅ docker installed, rebooting..."

sudo reboot
