FROM jekyll/jekyll:pages
MAINTAINER Hilmar Lapp <hlapp@drycafe.net>

ADD Gemfile* /srv/jekyll/
RUN chown -R jekyll:jekyll /srv/jekyll/*

# bundler does not want to be run using sudo or as root
USER jekyll
RUN \
    cd /srv/jekyll && \
    bundler install && \
    rm -r /srv/jekyll/*

# need to reset the user as which commands are run or otherwise running
# jekyll results in an error
USER root
