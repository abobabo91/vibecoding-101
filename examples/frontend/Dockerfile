# --- STAGE 1: DEVELOPMENT ---
# This stage is for your laptop. It's fast and allows hot-reloading.
FROM node:18-alpine AS development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Start the 'dev server' which watches your files for changes
CMD ["npm", "start"]

# --- STAGE 2: BUILD ---
# This stage compiles your TypeScript/React code into optimized, tiny files.
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# ARGS (Arguments) allow you to pass settings during the build process
ARG REACT_APP_CLERK_PUBLISHABLE_KEY
ARG OBFUSCATE=false

# If OBFUSCATE is set to true, we scramble the code before building
RUN if [ "$OBFUSCATE" = "true" ]; then \
    npm install -g javascript-obfuscator && \
    javascript-obfuscator ./src --output ./src --compact true --self-defending false; \
    fi

# Compile the React app
RUN npm run build

# --- STAGE 3: PRODUCTION ---
# This stage is for your server. It doesn't need Node.js; it just needs a simple web server (Nginx)
# to serve the compiled files from Stage 2.
FROM nginx:stable-alpine AS production
# Copy the compiled files from the 'build' stage into the Nginx folder
COPY --from=build /app/build /usr/share/nginx/html
# Copy your custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
