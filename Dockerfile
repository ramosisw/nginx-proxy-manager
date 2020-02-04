FROM jc21/nginx-proxy-manager:latest as build

RUN cd /app \
    && npm install sqlite3

FROM jc21/nginx-proxy-manager:latest as production

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

# App
ENV NODE_ENV=production


ADD src/backend/ /app/src/backend/

COPY --from=build /app/node_modules/sqlite3 /app/node_modules/sqlite3
COPY --from=build /app/node_modules/nopt /app/node_modules/nopt
COPY --from=build /app/node_modules/nan /app/node_modules/nan


# Volumes
VOLUME [ "/data", "/etc/letsencrypt" ]
CMD [ "/init" ]

# Ports
EXPOSE 80
EXPOSE 81
EXPOSE 443
EXPOSE 9876

HEALTHCHECK --interval=15s --timeout=3s CMD curl -f http://localhost:9876/health || exit 1

