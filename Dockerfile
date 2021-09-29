FROM alpine:3.13.6

ARG DB_HOST=mysql
ARG DB_NAME=dbName
ARG DB_USER=root
ARG DB_PASS=password
ARG S3_BUCKET=bucket
ARG S3_URL=fra1.digitaloceanspaces.com
ARG AWS_ACCESS_KEY_ID=secretId
ARG AWS_SECRET_ACCESS_KEY=secretKey

ENV DB_HOST=$DB_HOST
ENV DB_NAME=$DB_NAME
ENV DB_USER=$DB_USER
ENV DB_PASS=$DB_PASS
ENV S3_BUCKET=$S3_BUCKET
ENV S3_URL=$S3_URL
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

RUN echo $DB_HOST
RUN echo $DB_NAME

RUN apk -v --update add --no-cache \
			bash \
			mariadb-client \
			openssh-client && \
        rm -f /var/cache/apk/*

RUN pip install --upgrade awscli==1.18.69 python-magic
COPY dump.sh /

VOLUME /data

ENTRYPOINT ["/dump.sh"]
