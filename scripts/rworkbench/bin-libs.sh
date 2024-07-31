#!/bin/bash


# -- install any binary library dependenceis
apt-get install $(grep "^[^#;]" /opt/openapx/config/rworkbench/libs | tr '\n' ' ') -y --no-install-recommends


