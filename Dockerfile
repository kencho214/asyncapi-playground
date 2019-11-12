# --------------------------
# Build stage
# --------------------------
FROM node:10 as builder

USER node

ADD --chown=node ./package*.json /app/
WORKDIR /app

RUN npm ci --production

COPY --chown=node . /app

# --------------------------
# Copy to target image
# --------------------------
FROM node:10-alpine

USER node

EXPOSE 5000

COPY --from=builder --chown=node /app /app

WORKDIR /app

CMD ["node", "/app/src/server/index.js"]
