FROM node:12.18.4

WORKDIR /app/nuxt-project

RUN npm install -g @vue/cli

CMD ["/bin/sh"]

COPY ./nuxt-project/package*.json /app/
RUN npm install
RUN npm install -g create-nuxt-app

