FROM nginx:stable-alpine as production-stage
RUN mkdir /app
COPY /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
