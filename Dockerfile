# build stage
FROM node:16-alpine as build

WORKDIR /app

COPY . .
RUN npm i

RUN npx prisma db push --accept-data-loss
RUN npx generate
RUN npm run build

COPY /build ./

EXPOSE 3000
CMD ["node", "./index.js"]
