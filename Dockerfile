# Stage 1 - Builder
FROM node:20-alpine AS builder

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de dependência do frontend
COPY frontend/package*.json ./frontend/
COPY frontend/.npmrc ./frontend/

# Instala dependências
WORKDIR /app/frontend
RUN npm install

# Copia todo o código do frontend
COPY frontend ./frontend

# Executa o build do Next.js
RUN npm run build

# Stage 2 - Produção
FROM node:20-alpine

WORKDIR /app/frontend

# Define variáveis de ambiente e porta
ENV NODE_ENV=production
ENV PORT=3001

EXPOSE 3001

# Copia os arquivos necessários da imagem anterior
COPY --from=builder /app/frontend/.next ./.next
COPY --from=builder /app/frontend/public ./public
COPY --from=builder /app/frontend/node_modules ./node_modules
COPY --from=builder /app/frontend/package.json ./package.json
COPY --from=builder /app/frontend/next.config.js ./next.config.js

# Starta o app
CMD ["npm", "start"]
