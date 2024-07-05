FROM node:16-slim
RUN npm install -g firebase-tools@12.9.1
COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]
