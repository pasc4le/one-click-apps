FROM node:current-slim 

COPY . /tmp/build
WORKDIR /tmp/build

RUN npm i -g pnpm

RUN pnpm ci
RUN pnpm run validate_apps
RUN pnpm run build

FROM nginx
COPY --from=0 /tmp/build/dist /usr/share/nginx/html

EXPOSE 80
