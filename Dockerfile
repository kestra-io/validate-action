FROM kestra/kestra:v0.13.10-full
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]