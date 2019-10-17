### 础镜像说明
#### 操作系统信息
- centos : 7.5.1804 
- jdk : 1.8.0_211
- python : 2.7.5 
- font : simsun 
- arthas: 3.1.1
#### Tomcat 说明
- **tomcat7-Dockerfile** 支持Tomcat 7.0.55
- **tomcat8-Dockerfile** 支持Tomcat 8.5.20
 
#### 脚本说明
**`script/run_all.sh`** 支持war包 , jar包 ,zip包 发布

### 测试说明

 使用Docker Compose 测试(如果本地没有安装docker-compose 请自行安装,参考地址：https://docs.docker.com/compose/install/)  在demo这一级 运行:
 `docker-compose -f demo/demo-docker-compose.yaml build`
 `docker-compose -f demo/demo-docker-compose.yaml up -d`
 
 
