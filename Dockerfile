# Build phase

FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

# this step run npm build and generate output files into /app/build. this directory has to be copied to run the nginx
RUN npm run build 

# https://hub.docker.com/_/nginx
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

#no CMD or RUN step required. ngix default CMD is enough to run the nginx server