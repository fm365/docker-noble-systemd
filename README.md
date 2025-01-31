
# 构建镜像模版
```
docker build -t noble-systemd .
```
# 拉起容器
```
docker run -d -it --name test2 --privileged --cgroupns=host --tmpfs=/run --tmpfs=/tmp --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw  noble-systemd
```
