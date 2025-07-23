FROM postgres:16.4

# Cài đặt các phụ thuộc cần thiết cho Patroni
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Tạo môi trường ảo để tránh PEP 668
RUN python3 -m venv /patroni-venv
RUN /patroni-venv/bin/pip install --upgrade pip
RUN /patroni-venv/bin/pip install patroni[etcd]

# Đặt lệnh chạy Patroni
CMD ["/patroni-venv/bin/patroni", "/etc/patroni.yml"]
