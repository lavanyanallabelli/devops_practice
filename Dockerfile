# Use the official Node.js image as the base image
FROM node:20-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the /app
COPY code/package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY code/ ./

# Expose the port the app will run on
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]

