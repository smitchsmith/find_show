FROM phusion/passenger-customizable:0.9.20

ENV HOME /root
ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN /pd_build/utilities.sh
RUN /pd_build/ruby-2.4.*.sh
RUN bash -lc 'rvm install ruby-2.4.0-rc1'
RUN bash -lc 'rvm --default use ruby-2.4.0'
RUN /pd_build/redis.sh

# gems
RUN mkdir -p /home/app/findshow
WORKDIR /home/app/findshow
COPY Gemfile /home/app/findshow/
COPY Gemfile.lock /home/app/findshow/

RUN bundle install --deployment

ADD . /home/app/findshow
RUN chown -R app:app /home/app/findshow

RUN bundle exec rake assets:precompile

# nginx
EXPOSE 80
RUN rm /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down
ADD infrastructure/findshow.conf /etc/nginx/sites-enabled/findshow.conf
ADD infrastructure/postgres-env.conf /etc/nginx/main.d/postgres-env.conf

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
