FROM mariadb

ENV MYSQL_ROOT_PASSWORD 123456
ENV MYSQL_USER huser
ENV LC_ALL en_US.UTF-8

RUN mkdir -p /var/lib/mysql \
  && mkdir -p /var/log/mysql \
  && chown mysql:mysql /var/log/mysql

VOLUME /var/lib/mysql
 
#初始化数据库
ADD mysql_init.sh /root/mysql_init.sh
RUN chmod 775 /root/mysql_init.sh
RUN /root/mysql_init.sh
 
#导出端口
EXPOSE 3306
 
#添加启动文件
ADD mysql_run.sh /root/run.sh
RUN chmod 775 /root/run.sh
 
#设置默认启动命令
CMD ["/root/run.sh"]
