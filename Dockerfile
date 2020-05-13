# pull official base image
FROM node:alpine as build-stage 

# set working directory
WORKDIR /app

# Copying package.json and package-lock.json file from local root directory
# This file contains all dependencies that our app requires
COPY package.json /app/package.json

# installing necessary libraries (based on package.json  file copied in previous step)
RUN npm install --silent

# add app
COPY . /app

RUN npm run build --prod

# base image
FROM nginx:alpine

# copy artifact build from the 'build environment'
COPY --from=build-stage /app/build /usr/share/nginx/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
