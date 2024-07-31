#! /bin/bash


# -- set up install environment
echo "-- set up script scaffolding"
mkdir -p /sources/rworkbench


# -- install Open Source verison of Posit/R-Studio Workbench
echo "-- install Posit/R-Studio Workbench (open source license)"

# - download Posit workbench (Open Source license) for Ubuntu

XSOURCE=rstudio-server-2024.04.2-764-amd64.deb

echo "   downloading ${XSOURCE}" 
wget --quiet -P /sources/rworkbench https://download2.rstudio.org/server/jammy/amd64/${XSOURCE}


_MD5=($(md5sum /sources/rworkbench/${XSOURCE}))
_SHA256=($(sha256sum /sources/rworkbench/${XSOURCE}))

echo "   ${XSOURCE} (MD5 ${_MD5} / SHA-256 ${_SHA256})"

unset _MD5
unset _SHA256


# install the server
echo "   installing ${XSOURCE}"
gdebi --non-interactive /sources/rworkbench/${XSOURCE}

# stop workbench service ... if it was already started
echo "   stopping rstudio-server service (if automatically started)"
service rstudio-server stop

# -- end of install Open Source verison of Posit/R-Studio Workbench



# R version for use with Posit/workbench R-Studio 
# Open Source version of Posit/R-Studio Workbench only supports
# one version of R 
# note: poor man sort to select the latest version
WORKBENCH_R=$(ls /opt/R | grep "^[0-9].[0-9].[0-9]$" | sort -r | head -n1)

# set up symbolic link as a nice to have
ln -s /opt/R/${WORKBENCH_R} /opt/R/workbench

echo "-- Posit/R-Studio Workbench default R version ${WORKBENCH_R}"


# -- rserver.conf updates
echo "-- Configuring Posit/R-Studio Workbench defaults"

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



# create R workbench user group
echo "-- Configuring Posit/R-Studio Workbench groups"
groupadd rworkbench



# -- clean-up
echo "-- Clean up"
rm -Rf /sources

