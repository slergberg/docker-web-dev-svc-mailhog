# Base image
FROM ruby:2.6-alpine

# Base dependencies
RUN apk --no-cache add \
  build-base \
  curl \
  sqlite \
  sqlite-dev

# Application server
ADD Gemfile Gemfile.lock ./
RUN bundle install

# Expose ports
EXPOSE 25 1080

# Healthcheck
ADD ./docker-healthcheck.sh /usr/local/bin/docker-healthcheck
RUN chmod +x /usr/local/bin/docker-healthcheck
HEALTHCHECK CMD docker-healthcheck

# Startup
ENTRYPOINT ["mailcatcher", "-f"]
CMD ["--ip", "0.0.0.0", "--smtp-port", "25"]
