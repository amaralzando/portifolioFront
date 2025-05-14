# Stage 1 - Build
FROM node:20-alpine AS builder

WORKDIR /portifolio

# Copia arquivos de dependência
COPY frontend/package*.json ./web/

# Instala dependências
WORKDIR /portifolio/web
RUN npm install

# Copia código fonte e core
WORKDIR /portifolio
COPY frontend ./web
COPY core ./core

# Transpila o next.config.ts
WORKDIR /portifolio/web
RUN npm run prebuild

# Builda o Next.js
RUN npm run build

# Stage 2 - Runtime
FROM node:20-alpine

WORKDIR /portifolio/web

ENV NODE_ENV=production
ENV PORT=3001
EXPOSE 3001

COPY --from=builder /portifolio/web/.next ./.next
COPY --from=builder /portifolio/web/public ./public
COPY --from=builder /portifolio/web/node_modules ./node_modules
COPY --from=builder /portifolio/web/package.json ./package.json
COPY --from=builder /portifolio/web/dist/next.config.js ./next.config.js

CMD ["npm", "start"]
