FROM ghcr.io/crazy-max/samba:4.18.9

ENV IOMPI_UID=1000
ENV IOMPI_GID=1000
ENV IOMPI_PASSWORD=iompi
ENV SAMBA_WORKGROUP=WORKGROUP
ENV SAMBA_SERVER_STRING="IoMBian Samba Server"
ENV WSDD2_ENABLE=1
ENV WSDD2_HOSTNAME="iombian-samba-server"
ENV WSDD2_NETBIOS_NAME="iombian-samba-server"
ENV TZ=UTC

COPY config.yml /data/config.yml

EXPOSE 445 3702 5355

ENTRYPOINT [ "/init" ]

HEALTHCHECK --interval=30s --timeout=10s \
    CMD smbclient -L \\localhost -U % -m SMB3