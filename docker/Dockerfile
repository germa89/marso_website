# Multi-stage build for marso_website

# Stage 1: Build
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source files needed for build
COPY template.json index.template ./

# Generate index.html from mustache template
RUN npx mustache template.json index.template > index.html

# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy nginx configuration
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Copy static assets from project
COPY css /usr/share/nginx/html/css
COPY js /usr/share/nginx/html/js
COPY images /usr/share/nginx/html/images
COPY lib /usr/share/nginx/html/lib
COPY html /usr/share/nginx/html/html
COPY 404.html /usr/share/nginx/html/
COPY ads.txt /usr/share/nginx/html/

# Copy generated index.html from builder stage
COPY --from=builder /app/index.html /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
