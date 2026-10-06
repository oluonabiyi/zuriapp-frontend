# Stage 1: build the static site with Node
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
# Install scripts disabled: no third-party code runs at install time
RUN npm ci --ignore-scripts
COPY . .
ARG VITE_API_URL=""
ARG VITE_STORE_NAME="Zuri Market"
RUN VITE_API_URL=$VITE_API_URL VITE_STORE_NAME=$VITE_STORE_NAME npm run build

# Stage 2: serve the built files with nginx (no Node in the final image)
FROM nginxinc/nginx-unprivileged:stable-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
