FROM node:22-slim AS build
WORKDIR /repo/relay
COPY relay/package*.json ./
RUN npm ci
COPY relay/ ./
RUN npm run build && npm prune --omit=dev

FROM node:22-slim
WORKDIR /repo
COPY --from=build /repo/relay/node_modules relay/node_modules
COPY --from=build /repo/relay/dist relay/dist
COPY relay/package.json relay/
COPY relay/prompts relay/prompts
COPY contracts contracts
USER node
EXPOSE 8787
CMD ["node", "relay/dist/index.js"]
