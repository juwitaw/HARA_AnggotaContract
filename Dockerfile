FROM node:latest

ADD Truffle_test1 .

COPY ./Truffle_test1/package.json .

RUN npm install

CMD ["node", "./test/KartuAnggota_test.js"]



