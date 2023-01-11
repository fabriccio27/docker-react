FROM node:16-alpine AS builder

WORKDIR '/app'
COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# just by putting this second FROM statement we're indicating that the previous block has finished
FROM nginx 

# we know the destination folder by looking at the documentation of the nginx docker image
COPY --from=builder /app/build /usr/share/nginx/html