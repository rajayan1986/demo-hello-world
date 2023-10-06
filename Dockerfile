# Use the official Node.js LTS (Long Term Support) image as a base image
FROM node:18.16.0 AS build

WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/angular-hello-world /usr/share/nginx/html

EXPOSE 80

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
