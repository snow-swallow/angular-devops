# Pull base image.
FROM nginx:latest

RUN apt-get update -qq

# Install software.
RUN apt-get install -y

# Identify ssl cert files.
RUN mkdir /etc/nginx/certs
ADD ./bin/ssl/server.crt /etc/nginx/certs/server.crt
ADD ./bin/ssl/server.key /etc/nginx/certs/server.key

# Define working directory.
WORKDIR /usr/share/nginx/html
COPY ./bin/nginx.conf /etc/nginx/nginx.conf
COPY ./dist/ .

# Define default command.
CMD ["nginx", "-g", "daemon off;"]

# Expose ports.
EXPOSE 80
EXPOSE 443