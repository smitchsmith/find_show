FROM phusion/passenger-customizable:0.9.20

ENV HOME /root
ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN /pd_build/utilities.sh
RUN /pd_build/ruby-2.4.0.sh
RUN /pd_build/nodejs.sh
RUN bash -lc 'rvm --default use ruby-2.4.0'
RUN /pd_build/redis.sh

# phantomjs # https://gist.github.com/julionc/7476620
RUN apt-get update
RUN apt-get -y install build-essential chrpath libssl-dev libxft-dev
RUN apt-get -y install libfreetype6 libfreetype6-dev
RUN apt-get -y install libfontconfig1 libfontconfig1-dev
WORKDIR /tmp
RUN curl --silent -L -o phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar xvjf phantomjs.tar.bz2
RUN mv phantomjs-2.1.1-linux-x86_64 /usr/local/share
RUN ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin

# gems
RUN gem update --system
RUN mkdir -p /home/app/findshow
WORKDIR /home/app/findshow
COPY Gemfile /home/app/findshow/
COPY Gemfile.lock /home/app/findshow/
RUN bundle install --deployment

ADD . /home/app/findshow
RUN chown -R app:app /home/app/findshow

# npm packages
WORKDIR /home/app/findshow/client
RUN npm install -g yarn
RUN yarn install
WORKDIR /home/app/findshow

RUN bundle exec rake assets:precompile

# nginx
EXPOSE 80
RUN rm /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down
ADD infrastructure/findshow.conf /etc/nginx/sites-enabled/findshow.conf
ADD infrastructure/postgres-env.conf /etc/nginx/main.d/postgres-env.conf

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
