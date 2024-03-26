# IoMBian Samba

Custom image to share a local folder through Samba very easily on IoMBian devices.

The shared folder has the following characteristics:

- Browsable
- Read/Write
- Authentication required (no guest access allowed)


## Build the image

To build the docker image, from the cloned repository, execute the docker build command in the same level as the Dockerfile:

```
docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .
```

For example: ```docker build -t iombian-samba:latest .```


## Launch de container

After building the image, execute it with docker run:

```
docker run --name ${CONTAINER_NAME} --rm -d -v /data:/samba/data -p 445:445 -p 3702:3702 -p 5355:5355 -e TZ=Europe/Madrid iombian-samba:latest
```

- **--name** is used to define the name of the created container.
- **--rm** can be used to delete the container when it stops. This parameter is optional.
- **-d** is used to run the container detached. This way the container will run in the background. This parameter is optional.
- **-v** is used to map the folder that is going to be shared trought Samba.
- **-p** is used to map a port of the container on the host.
- **-e** can be used to define the environment variables:
  - IOMPI_UID: the uid (user id) of the iompi user. Default value is 1000.
  - IOMPI_GID: the gid (group id) of the iompi user. Default value is 1000.
  - IOMPI_PASSWORD: the password of the iompi user. Default value is iompi.
  - SAMBA_WORKGROUP: the workgroup name of the Samba server. Default value is WORKGROUP.
  - SAMBA_SERVER_STRING: the server string of the Samba server. Default value is "IoMBian Samba Server".
  - WSDD2_ENABLE: enable service discovery for Windows. Default value is 1 (true).
  - WSDD2_HOSTNAME: hostname value for service discovery for Windows. Default value is iombian-samba-server.
  - WSDD2_NETBIOS_NAME: NetBIOS name for service discovery for Windows. Default value is iombian-samba-server.
  - TZ: the timezone to be used inside the container. Default value is UTC.

Otherwise, a ```docker-compose.yml``` file can also be used to launch the container:

```yaml
version: '3'

services:
  iombian-samba:
    image: iombian-samba:latest
    container_name: iombian-samba
    restart: unless-stopped
    cap_add:
      - CAP_NET_ADMIN
      - CAP_NET_RAW
    ports:
      - "445:445"
      - "3702:3702"
      - "5355:5355"
    volumes:
      - "/data:/samba/data"
    environment:
      - "TZ=Europe/Madrid"
```

```
docker compose up -d
```

## Author

(c) 2024 [Aitor Iturrioz Rodríguez](https://github.com/bodiroga) ([Tknika](https://tknika.eus/))