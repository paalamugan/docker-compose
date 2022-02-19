# Create a group
RUN groupadd -r app

# Create a user
RUN useradd -g app app

# Set ownership and permissions
RUN chown -R app:app /app

# Switch to user
USER app

# Application setup
FROM node:17-alpine

WORKDIR /app

COPY package*.json .

RUN npm install --production

COPY . .

RUN npm run build

CMD ["node", "dist/index.js"]
