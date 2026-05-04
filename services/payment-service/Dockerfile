FROM node:18-slim

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY . .

EXPOSE 8004
RUN adduser --disabled-password appuser
USER appuser
CMD ["npm", "start"]
