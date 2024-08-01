# docker-rworkbench
A container extending [openapx/rbatch](https://github.com/openapx/docker-rbatch) with the addition of the Open Source version of Posit/R-Studio Workbench IDE application for use within the Life Science and other regulated industries.

<br>

### Getting Started
The container images are available on Docker Hub (https://hub.docker.com/repository/docker/openapx/rworkbench). 

Get the latest release (corresponds to the *main* branch), for Ubuntu in this case, and connect using a standard shell.
```
$ docker pull openapx/rworkbench:latest-ubuntu
$ docker run -dit -p <port>:8787 openapx/rworkbench:latest-ubuntu
```

The current release exposes the Posit/R-Studio Worbench application as `HTTP` only and on standard port 8787. Near-future plans include support for exposing the Workbench application on both `HTTP` (port 80) and `HTTPS` (port 443).

<br>

The `openapx/rworkbench` container does not define a default user, but one can easily be created using the rworkbench adduser script.
```
$ docker exec -it <image> /opt/openapx/utilities/rworkbench_adduser.sh <user>
```

The `image` refers to a docker reference for the running image.


<br>
To connect to the `openapz/rworkbench` container without starting the Posit/R-Studio Workbench service, override the entry point.
```
$ docker run -it --entrypoint=/bin/bash openapx/rworkbench:latest-ubuntu
```

If you intend to manually start the Posit/R-Studio Workbench service, include the port mapping option `-p <port>:8787`.

<br>

### Basic configuration
The Posit/R-Studio Workbench application is installed in the `openapx/rworkbench` container using default installation options.

As the Open Source license only supports one R version, the last R version patch release (using R version number as a reference) is enabled via the `/opt/R/workbench` symbolic link. 

The Workbench server configuration is updated to specify

- Default R version set to `/opt/R/workbench` (`rsession-which-r`)
- Workbench server process not run as a process daemon (`server-daemonize`)

The Posit/R-Studio Workbench process is started automatically via the `entrypoint.sh` script in the root of the files system. The start command does not specify any configuration parameters or options. All those options are defined in the server configuration file. 

<br>

### Compliance
The `openapx/rworkbench` container will be documented to support Life Science GxP-level validation and validation requirements for other regulated industries. 

The formal validation of is the Workbench application and any package installed is the responsibility of each individual organization that uses the `openapx/rworkbench` container, our aim is to save you a lot of effort.

The compliance documentation planned for `openapx/rworkbench` container is the equivalent to Installation Qualification (IQ) and Operational Qualification (OQ) and will cover the following steps for each R version.

- Download from source
- Installation logs (IQ)
- Operational checks (OQ)

<br>

### License
The `openapx/rworkbench` container uses the Apache license (see LICENSE file in the root of the repository). 

The `openapx/rworkbench` container is based on other software, tools, utilities, etc that in turn has their own individual licenses. As always, it is the responsibility of each individual organization and/or user that uses `openapz/rworkbench` to verify that their use is permitted under said licenses.



