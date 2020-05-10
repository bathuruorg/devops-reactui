# pull official base image
FROM node:13.12.0-alpine

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# Copying package.json and package-lock.json file from local root directory
# This file contains all dependencies that our app requires
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json

# installing necessary libraries (based on package.json  file copied in previous step)
RUN npm install --silent

# add app
COPY . /app

# Uses port which is used by the actual application
EXPOSE 3000

# start app
CMD ["npm", "start"]
