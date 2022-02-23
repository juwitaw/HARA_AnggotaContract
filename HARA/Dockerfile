FROM node:12-alpine

COPY ./Truffle_test1/package.json ./Truffle_test1/package.json

RUN npm install --unsafe-perm -g truffle@5.1.65
WORKDIR Truffle_test1
RUN npm install

ADD Truffle_test1 .


CMD ["npm", "run", "test"]



