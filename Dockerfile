```
# 使用Ubuntu 24.04.1 基础镜像
FROM fm365/ubuntu-24.04.1:v3

# 维护者信息（可选）
LABEL maintainer="fm2008@gmail.com"

# 设置非交互模式，避免安装时弹出交互界面
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装一些常用工具
RUN apt-get update && \
    apt-get install -y --no-install-recommends rsyslog software-properties-common systemd systemd-cron locales sudo dbus && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man
RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

# Remove unnecessary units
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
  /etc/systemd/system/*.wants/* \
  /lib/systemd/system/local-fs.target.wants/* \
  /lib/systemd/system/sockets.target.wants/*udev* \
  /lib/systemd/system/sockets.target.wants/*initctl* \
  /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
  /lib/systemd/system/systemd-update-utmp* \
  /lib/systemd/system/getty.target

STOPSIGNAL SIGRTMIN+3

# 设置环境变量以使用 UTF-8 编码
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# 创建 systemd 目录（某些情况下 systemd 需要）
VOLUME [ "/sys/fs/cgroup" ]
VOLUME [ "/tmp", "/run", "/run/lock" ]

# 设置默认工作目录
WORKDIR /root

# 设定默认启动命令
#CMD ["/start.sh"]
CMD ["/sbin/init"]
#CMD [ "/lib/systemd/systemd", "log-level=info", "unit=sysinit.target" ]
```
