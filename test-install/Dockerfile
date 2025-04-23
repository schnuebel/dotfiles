# muss im parent dir gebaut werden weil da das install.sh script liegt
# sudo docker build -t test -f test-install/Dockerfile .


FROM ubuntu:24.04

WORKDIR /root

RUN apt-get update && \
    apt-get install -y git bash && \
    apt-get clean

RUN git clone https://github.com/schnuebel/dotfiles.git

WORKDIR /root/dotfiles

COPY install.sh /root/dotfiles/install.sh

RUN chmod +x install.sh

CMD ["./install.sh"]


