FROM fedora:latest

RUN dnf -y update && \
  dnf -y install python3 python3-pip && \
  dnf clean all && \
  rm -rf /var/cache/libdnf5/*

RUN dnf -y install \
    ruby \
    ruby-devel \
    openssl-devel \
    redhat-rpm-config \
    gcc-c++ \
    @development-tools && \
  dnf clean all && \
  rm -rf /var/cache/libdnf5/*

RUN mkdir -p /home/jekyll && \
  useradd -ms /bin/bash jekyll && \
  chown -R jekyll:jekyll /home/jekyll && \
  mkdir -p /home/jekyll/gems && \
  chown -R jekyll:jekyll /home/jekyll/gems && \
  chmod -R u+rwx,g+rwx,o+rwx /home/jekyll/gems && \
  echo '# Install Ruby Gems to ~/gems' >> /home/jekyll/.bashrc && \
  echo 'export GEM_HOME=$HOME/gems' >> /home/jekyll/.bashrc && \
  echo 'export PATH=$HOME/gems/bin:$PATH' >> /home/jekyll/.bashrc

# RUN gem install jekyll bundler

ENV HOME=/home/jekyll
WORKDIR /home/jekyll
USER jekyll
