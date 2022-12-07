FROM nginx:1.23-alpine

# hadolint ignore=DL3022
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.5.0 /lambda-adapter /opt/extensions/lambda-adapter

WORKDIR /tmp

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/conf.d /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]
