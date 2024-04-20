ARG IMAGE_TAG=latest-full
FROM kestra/kestra:$IMAGE_TAG

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
