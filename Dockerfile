# Use Node.js base image (LTS version)
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Clean install
RUN rm -rf node_modules && \
    npm cache clean --force && \
    npm install --legacy-peer-deps --prefer-offline && \
    npm install -g serve

RUN npm install ajv ajv-keywords --legacy-peer-deps

# Copy all files
COPY . .

# Build app
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Start the app using serve
CMD ["serve", "-s", "build", "-l", "3000"]
