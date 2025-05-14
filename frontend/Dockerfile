# Stage 1 - Builder
FROM node:20-alpine as builder

# Define o diretório de trabalho conforme sua estrutura
WORKDIR /home/gasa/portifolio/frontend

# Copia os arquivos de dependência primeiro para melhor cache
COPY package*.json ./
COPY .npmrc ./

# Instala as dependências
RUN npm ci

# Copia todos os arquivos do projeto
COPY . .

# Executa o build
RUN npm run build

# Stage 2 - Produção
FROM node:20-alpine

# Mantém a mesma estrutura de diretórios
WORKDIR /home/gasa/portifolio/frontend

# Variáveis de ambiente
ENV NODE_ENV=production
ENV PORT=3001

# Expõe a porta 3001
EXPOSE 3001

# Copia apenas o necessário do estágio de build
COPY --from=builder /home/gasa/portifolio/frontend/.next ./.next
COPY --from=builder /home/gasa/portifolio/frontend/public ./public
COPY --from=builder /home/gasa/portifolio/frontend/node_modules ./node_modules
COPY --from=builder /home/gasa/portifolio/frontend/package.json ./package.json
COPY --from=builder /home/gasa/portifolio/frontend/next.config.js ./next.config.js

# Comando para iniciar a aplicação
CMD ["npm", "start"]