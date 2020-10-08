#---named builder...(build phase)
FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

#----named builde....(run phase)
FROM nginx

#---This will not work in aws. So use -from==0 (position instead of name)
COPY --from=builder /app/build /usr/share/nginx/html

#---default command will start the nginx...