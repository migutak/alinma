FROM oraclelinux:7-slim

ARG release=19
ARG update=5

RUN yum -y install curl
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash -
RUN yum -y install nodejs

RUN  yum -y install oracle-release-el7 && yum-config-manager --enable ol7_oracle_instantclient && \
     yum -y install oracle-instantclient${release}.${update}-basic oracle-instantclient${release}.${update}-devel oracle-instantclient${release}.${update}-sqlplus && \
     rm -rf /var/cache/yum


RUN mkdir -p /app/alinmmaapis
WORKDIR /app/alinmmaapis
COPY package*.json /app/alinmmaapis/
COPY . /app/alinmmaapis
RUN npm install --only=production

# CMD ["sqlplus", "-v"]

EXPOSE 3000

CMD ["node","."]

# docker build -t 52.117.54.217:5000/alinmmaapis:v1 . 
# docker build -t 172.16.19.151:5000/alinmmaapis:2.0.0 -f dockerFile-oracleClient . 
# docker run -it --name apis -p 8000:8000 migutak/alinmmaapis:2.0.0


