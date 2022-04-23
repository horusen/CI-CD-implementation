FROM node:alpine AS dev

WORKDIR /app

COPY package*.json .

RUN npm install --only=development

COPY . .

RUN npm run build


FROM node:alpine as prod

ARG NODE_ENV=production

WORKDIR /app

COPY package*.json .

RUN npm install --only=production

COPY . .

COPY --from=dev /app/dist ./dist

CMD [ "node", "dist/main" ]