# Stage 1 - Build
FROM node:20-alpine AS builder

# Define a raiz do projeto
WORKDIR /portifolio

# Copia package.json e lock para /portifolio/web
COPY frontend/package*.json ./web/

# Entra na pasta web para instalar
WORKDIR /portifolio/web
RUN npm install

# Volta à raiz e copia o projeto inteiro
WORKDIR /portifolio
COPY frontend ./web

# Volta novamente para web e builda
WORKDIR /portifolio/web
RUN npm run build

# Stage 2 - Produção
FROM node:20-alpine

WORKDIR /portifolio/web

ENV NODE_ENV=production
ENV PORT=3001
EXPOSE 3001

# Copia os arquivos finais do builder
COPY --from=builder /portifolio/web/.next ./.next
COPY --from=builder /portifolio/web/public ./public
COPY --from=builder /portifolio/web/node_modules ./node_modules
COPY --from=builder /portifolio/web/package.json ./package.json
COPY --from=builder /portifolio/web/next.config.js ./next.config.js

CMD ["npm", "start"]
