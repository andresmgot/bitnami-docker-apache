FROM gcr.io/stacksmith-images/minideb:jessie-r8
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_IMAGE_VERSION=2.4.25-r2 \
    BITNAMI_APP_NAME=apache \
    BITNAMI_APP_USER=daemon

# System packages required
RUN install_packages libssl1.0.0 libaprutil1 libapr1 libc6 libuuid1 libexpat1 libpcre3 libldap-2.4-2 libsasl2-2 libgnutls-deb0-28 zlib1g libp11-kit0 libtasn1-6 libnettle4 libhogweed2 libgmp10 libffi6

# Install apache
RUN bitnami-pkg unpack apache-2.4.25-0 --checksum ce66b36edd89fb840c98cab3121e9042b8012728ad1e5bab233148770dd877b1
RUN ln -sf /opt/bitnami/$BITNAMI_APP_NAME/htdocs /app

ENV PATH=/opt/bitnami/$BITNAMI_APP_NAME/sbin:/opt/bitnami/$BITNAMI_APP_NAME/bin:/opt/bitnami/common/bin:$PATH

COPY rootfs/ /
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["nami", "start", "--foreground", "apache"]

VOLUME ["/bitnami/$BITNAMI_APP_NAME"]

WORKDIR /app

EXPOSE 80 443
