FROM node:latest

# install simple http server for serving static content
RUN npm install -g express

# make the 'app' folder the current working directory
WORKDIR /app

# copy both 'package.json' and 'package-lock.json' (if available)
COPY --chown=1001:0 package*.json ./

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY --chown=1001:0 . .
RUN chmod 755 -R /app

# build app for production with minification
#RUN npm run build

EXPOSE 3000
CMD [ "node", "index.js"]
