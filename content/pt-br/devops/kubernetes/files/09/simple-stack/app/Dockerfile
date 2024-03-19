# Start from a Node.js base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json into the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application into the container
COPY . .

# Expose the port your application runs on
EXPOSE 3000

# Set the command to run your application
CMD [ "node", "app.js" ]