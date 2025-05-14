# Stage 1 - Build
FROM node:20-alpine AS builder

# Cria estrutura esperada
WORKDIR /portifolio

# Copia arquivos de dependência
COPY frontend/package*.json ./web/

# Instala dependências
WORKDIR /portifolio/web
RUN npm install

# Volta à raiz e copia o frontend + core
WORKDIR /portifolio
COPY frontend ./web
COPY core ./core 

# Volta para web e builda o Next.js
WORKDIR /portifolio/web
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
COPY --from=builder /portifolio/web/next.config.ts ./next.config.ts

CMD ["npm", "start"]

