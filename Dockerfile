# Create a group
RUN groupadd -r app

# Create a user
RUN useradd -g app app

# Set ownership and permissions
RUN chown -R app:app /app

# Switch to user
USER app

# Application setup from here

# Supported tags and respective Dockerfile links, 17-alpine3.14, 17.4-alpine3.14, 17.4.0-alpine3.14, alpine3.14, current-alpine3.14
FROM node:17-alpine  

WORKDIR /app

COPY package*.json .

RUN npm install --production

COPY . .

RUN npm run build

CMD ["node", "dist/index.js"]
