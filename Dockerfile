# build stage
FROM node:16-alpine as build

WORKDIR /app

COPY . .
RUN npm i
RUN npm run build

# run stage
FROM node:16-alpine as run

WORKDIR /app


COPY --from=build /app ./
COPY --from=build /app/build ./
COPY ./firebase-key.json .
COPY --from=build /app/scripts/prodServer.js ./server.js

EXPOSE 3000
CMD ["node", "./server.js"]
