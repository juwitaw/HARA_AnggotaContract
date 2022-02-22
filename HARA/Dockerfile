FROM node:12-alpine

COPY ./Truffle_test1/package.json .

RUN npm install
RUN npm install -g truffle

ADD Truffle_test1 .

CMD ["node", "./contracts/KartuAnggota.sol"]



