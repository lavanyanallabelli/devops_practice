# ============================================
# STAGE 1: Builder (Install dependencies)
# ============================================
FROM node:20.11.0-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files ONLY (for layer caching)
COPY code/package*.json ./

# Install dependencies (cached unless package.json changes)
# npm ci is faster and more reliable than npm install
RUN npm ci --only=production && \
    npm cache clean --force

# ============================================
# STAGE 2: Production (Final slim image)
# ============================================
FROM node:20.11.0-alpine

# Install curl for health checks (Alpine uses apk, not apt-get)
RUN apk add --no-cache curl

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Set working directory
WORKDIR /app

# Copy node_modules from builder stage (with proper ownership)
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules

# Copy application code (with proper ownership)
COPY --chown=nodejs:nodejs code/ ./

# Switch to non-root user (CRITICAL for security)
USER nodejs

# Health check - automatically monitors app health
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Expose port (documentation only, doesn't actually open port)
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]



# Use the official Node.js image as the base image
# FROM node:20-bullseye
# 
# Set the working directory in the container
# WORKDIR /app
# 
# Copy the package.json and package-lock.json files to the /app
# COPY code/package*.json ./
# 
# Install the dependencies
# RUN npm install
# 
# Copy the rest of the application code to the working directory
# COPY code/ ./
# 
# Install curl
# RUN apt-get update && apt-get install -y curl
# 
# Expose the port the app will run on
# EXPOSE 3000
# 
# Start the application
# CMD ["node", "app.js"]

