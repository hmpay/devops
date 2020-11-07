FROM mariadb

#初始化数据库
RUN \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"huser\"@\"%\" identified by \"24gpqfwZSALKryYJ\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

VOLUME ["/etc/mysql", "/var/lib/mysql"]

WORKDIR /data

CMD ["mysqld_safe"]
 
#导出端口
EXPOSE 3306