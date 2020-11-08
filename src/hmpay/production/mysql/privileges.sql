use mysql;
select host, user from user;
-- 因为mysql版本是5.7，因此新建用户为如下命令：
create user IF NOT EXISTS  huser identified by 'NcUE4mtaJRQr96sR';
-- 将hmpay数据库的权限授权给创建的huser用户，密码为NcUE4mtaJRQr96sR：
grant all on hmpay.* to huser@'%' identified by 'NcUE4mtaJRQr96sR' with grant option;
-- 这一条命令一定要有：
flush privileges;