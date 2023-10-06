# Use the official Node.js LTS (Long Term Support) image as a base image
FROM node:18.16.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install Angular CLI globally (if not already installed)
RUN npm install -g @angular/cli

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Angular application for production
RUN npm run build

# Create a new image for the production application
FROM nginx:alpine

# Copy the built Angular app from the previous stage to the NGINX web server directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
