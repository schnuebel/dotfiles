# muss im parent dir gebaut werden weil da das install.sh script liegt
# sudo docker build -t test -f test-install/Dockerfile .


FROM ubuntu:24.04

WORKDIR /root

RUN apt-get update && \
    apt-get install -y git bash && \
    apt-get clean

WORKDIR /root

COPY . /root/dotfiles

CMD cd dotfiles && chmod +x install.sh && ./install.sh


