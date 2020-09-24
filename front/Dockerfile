FROM node:12.18.4

WORKDIR /app/vue-project

RUN npm install -g @vue/cli
RUN npm install 

COPY ./vue-project/package*.json /app/
CMD ["/bin/sh"]

# RUN npm install axios
