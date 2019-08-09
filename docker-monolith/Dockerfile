FROM ubuntu:16.04

# refresh cache of repo & install required packages
RUN apt-get update
RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
RUN gem install bundler

# download app to the container
RUN git clone -b monolith https://github.com/express42/reddit.git

# copy cfg files
COPY mongod.conf /etc/mongod.conf
COPY db_config /reddit/db_config
COPY start.sh /start.sh

# install app dependencies & configure the app
RUN cd /reddit && bundle install
RUN chmod 0777 /start.sh

# Once container is started, the service(app) is started too
CMD ["/start.sh"]
