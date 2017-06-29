FROM alpine:3.6

RUN apk add --no-cache \
      tzdata \
    && cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime \
    && echo "America/Los_Angeles" > /etc/timezone \
    && date \
    && apk del tzdata

COPY diff-so-fancy diff-highlight /usr/local/bin/

RUN apk add --no-cache \
    perl \
    less \
    bash \
    ca-certificates \
    curl \
    openssh-client \
    git \
    vim \
    ctags \
    ncurses

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git /root/.bash_it \
    && /root/.bash_it/install.sh --silent

RUN git clone --depth=1 git://github.com/amix/vimrc.git /root/.vim_runtime \
    && sh /root/.vim_runtime/install_awesome_vimrc.sh

#RUN apk add --no-cache \
#    foo

COPY .gitconfig /root/.gitconfig
COPY my_configs.vim /root/.vim_runtime/
RUN bash -c "source /root/.bashrc \
        && bash-it enable alias git \
        && bash-it enable completion git \
        "
COPY bashrc /root/.bashrc
COPY custom.aliases.bash /root/.bash_it/custom/

RUN mkdir -p /usr/src/app
WORKDIR /root

CMD ["bash"]
