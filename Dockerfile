FROM node:14 AS build

WORKDIR /faucet

COPY . .
RUN yarn install --frozen-lockfile
RUN yarn run build


FROM node:14

WORKDIR /faucet

COPY package.json .
COPY yarn.lock .
COPY --from=build /faucet/lib/ /faucet/lib/
RUN yarn install --frozen-lockfile --production

CMD ["yarn", "start"]

