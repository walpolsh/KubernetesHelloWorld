# Use the official Node.js 16 image as a parent image
FROM --platform=linux/amd64 node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Inform Docker that the container is listening on the specified port at runtime.
EXPOSE 3000

# Run the specified command within the container.
CMD [ "node", "server.js" ]
