FROM mariadb

#设置环境变量，便于管理
ENV MARIADB_USER huser
ENV MARIADB_PASS 24gpqfwZSALKryYJ

#让容器支持中文
ENV LC_ALL en_US.UTF-8


#初始化数据库
ADD mysql_init.sh /root/db_init.sh
RUN chmod 775 /root/db_init.sh
RUN /root/db_init.sh
 
#导出端口
EXPOSE 3306
 
#添加启动文件
ADD mysql_run.sh /root/run.sh
RUN chmod 775 /root/run.sh
 
#设置默认启动命令
CMD ["/root/run.sh"]

