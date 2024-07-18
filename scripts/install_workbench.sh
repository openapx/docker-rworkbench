#! /bin/bash


mkdir -p /sources/install/workbench


# install system dependencies
apt-get install -y --no-install-recommends gdebi-core

# download Posit workbench (Open Source license) for Ubuntu
cd /sources/install/workbench
wget --quiet https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.04.2-764-amd64.deb

# install the server
gdebi --non-interactive rstudio-server-2024.04.2-764-amd64.deb


# stop workbench service if it was already started
setvice rstudio-server stop


# R version for use with Posit/workbench R-Studio 
# Open Source version of Posit/R-Studio Workbench only supports
# one version of R 
ln -s /opt/R/4.4.1 /opt/R/rstudio
echo "rsession-which-r=/opt/R/rstudio/bin/R" > rserver.conf


# clean-up
rm -Rf /sources

