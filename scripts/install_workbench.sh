#! /bin/bash


# -- set up install environment
mkdir -p /sources/install/workbench


# -- install system dependencies
apt-get install -y --no-install-recommends gdebi-core


# -- install Open Source verison of Posit/R-Studio Workbench

# download Posit workbench (Open Source license) for Ubuntu
cd /sources/install/workbench
wget --quiet https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.04.2-764-amd64.deb

# install the server
gdebi --non-interactive rstudio-server-2024.04.2-764-amd64.deb

# stop workbench service ... if it was already started
setvice rstudio-server stop

# -- end of install Open Source verison of Posit/R-Studio Workbench



# R version for use with Posit/workbench R-Studio 
# Open Source version of Posit/R-Studio Workbench only supports
# one version of R 
# note: poor man sort to select the latest version
WORKBENCH_R=$(ls /opt/R | grep "^[0-9].[0-9].[0-9]$" | sort -r | head -n1)

# set up symbolic link as a nice to have
ln -s /opt/R/${WORKBENCH_R} /opt/R/workbench



# -- rserver.conf updates

# comment pointer to R if it exists ... not really tested
sed -e '/rsession-which-r/ s/^#*/#/' -i /etc/rstudio/rserver.conf

# add configuration
cat <<EOT >> /etc/rstudio/rserver.conf
# --- openapx configuration -------------------------------------------

# -- adding pointer to R version
rsession-which-r=/opt/R/workbench/bin/R

# -- do not run Workbench server as a background deamon
server-daemonize=0

# --- end of openapx configuration ------------------------------------
EOT

# -- end of rserver.conf updates


# -- clean-up
rm -Rf /sources

