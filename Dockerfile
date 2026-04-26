FROM nginx:1.27-alpine

COPY index.html /usr/share/nginx/html/index.html
COPY assets/ /usr/share/nginx/html/assets/
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

ENV PORT=8080
ENV NGINX_ENVSUBST_FILTER="^PORT$"
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
