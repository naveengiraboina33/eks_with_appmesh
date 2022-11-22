FROM public.ecr.aws/bitnami/ruby:latest
FROM ruby:2.6.6-slim-buster

# MAINTAINER massimo@it20.info

################## BEGIN INSTALLATION ######################

# Set the working directory to /app
WORKDIR /app

COPY yelb-appserver.rb yelb-appserver.rb 
COPY Gemfile Gemfile
COPY modules modules

ENV LANG=en_us.UTF-8
ENV LC_ALL=C.UTF-8
ENV RACK_ENV=production

RUN gem install sinatra --no-document
RUN gem install redis --no-document
### hack to allow the setup of the pg gem (which would fail otherwise)
RUN apt-get update -y
# RUN apt-get install postgresql -y

RUN apt update && apt install -y \
    build-essential libpq-dev  \
    && rm -rf /var/lib/apt/lists/*

# RUN gem install pg
# RUN apt install postgresql-server-dev-all -y

# RUN apt-get install ruby-dev -y
# RUN  xcode-select --install


### end of hack (this would require additional research and optimization)
# RUN gem bundle install

RUN gem install pg 

# RUN gem aws-sdk



### this installs the AWS SDK for DynamoDB (so that appserver can talk to DDB Vs the default Postgres/Redis)
RUN gem install aws-sdk-dynamodb pg  --no-document
# Set the working directory to /
WORKDIR /
ADD startup.sh startup.sh

##################### INSTALLATION END #####################

CMD ["./startup.sh"]


