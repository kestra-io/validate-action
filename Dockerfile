FROM kestra/kestra:v0.16.12-full

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
