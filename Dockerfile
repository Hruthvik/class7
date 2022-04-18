FROM ubuntu:18.04

WORKDIR /root
COPY ./Dockerfile /root
RUN apt-get update && apt-get install -y openssh-server

RUN apt-get install -y git

RUN mkdir /var/run/sshd
RUN echo 'root:oss2022spring' | chpasswd

RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginid.so@g' /etc/pam.d/sshd
ENV NOTVISIBLE="in user profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

RUN mkdir /root/project
WORKDIR /root/project
RUN git init
RUN git config --global user.name "Hruthvik"
RUN git config --global user.email "hruthvikraj26@gmail.com"
COPY ./aaa.txt /root/project
COPY ./bbb.txt /root/project
COPY ./ccc.txt /root/project

RUN git add aaa.txt
RUN git commit -a -m "The file aaa.txt has been added"
RUN git add bbb.txt
RUN git commit -a -m "The file bbb.txt has been added"
RUN git add ccc.txt
RUN git commit -a -m "The file ccc.txt has been added"

RUN git checkout -b feat
RUN mkdir /root/project/feat1
WORKDIR /root/project/feat1
COPY ./xxx.txt /root/project/feat1
COPY ./yyy.txt /root/project/feat1
COPY ./zzz.txt /root/project/feat1

RUN git add xxx.txt
RUN git commit -a -m "The file xxx.txt has been added to the branch feat1"
RUN git add yyy.txt
RUN git commit -a -m "The file yyy.txt has been added to the branch feat1"
RUN git add zzz.txt
RUN git commit -a -m "The file zzz.txt has been added to the branch feat1"

