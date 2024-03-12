# Use the official Ubuntu base image
FROM ubuntu:20.04

# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Create a working directory for your application
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY . .

# Expose the port your application uses
EXPOSE 8081

# Command to run your application
CMD ["node", "app.js"]
