FROM alpine:latest

RUN \
    set -x && \
    apk update && \
    apk -Uuv add nginx python py2-pip curl ca-certificates openssl && \
    pip install awscli yq==2.2.0 && \
    apk --purge -v del py2-pip && \
    rm /var/cache/apk/*

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
      && chmod +x ./kubectl \
      && mv ./kubectl /usr/local/bin/kubectl \
      && kubectl version --client

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.default.conf /etc/nginx/conf.d/default.conf

# Add a hello index file
COPY index.html /var/www/localhost/htdocs

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]

