FROM nginx:1.15.0-alpine
COPY docs/build/html /usr/share/nginx/html
