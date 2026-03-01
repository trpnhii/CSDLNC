# Stage 1: Build the React application
FROM node:18-alpine AS builder

WORKDIR /app

# Install OS build deps required by some npm packages
RUN apk add --no-cache --virtual .build-deps python3 make g++ \
    && ln -sf /usr/bin/python3 /usr/bin/python

# Copy package files first for cached install
COPY package*.json ./

# Use npm ci for reproducible installs. Add legacy-peer-deps for peer conflicts and skip optional packages.
RUN npm ci --legacy-peer-deps --no-optional

# Copy application sources
COPY . .

# Build the React app
RUN npm run build

# Cleanup build deps to reduce image size
RUN apk del .build-deps || true

# Stage 2: Serve with nginx
FROM nginx:stable-alpine

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the built application from builder
COPY --from=builder /app/build /usr/share/nginx/html

# Remove default nginx config
RUN rm -f /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
