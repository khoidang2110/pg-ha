FROM postgres:16.4

# Cài đặt các phụ thuộc hệ thống cần thiết cho psycopg2 và Patroni
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Tạo môi trường ảo để tránh PEP 668
RUN python3 -m venv /patroni-venv
RUN /patroni-venv/bin/pip install --upgrade pip
RUN /patroni-venv/bin/pip install patroni[etcd] psycopg2-binary

# Đảm bảo quyền cho thư mục dữ liệu
RUN chown -R postgres:postgres /var/lib/postgresql && chmod -R 0700 /var/lib/postgresql

# Chuyển sang user postgres
USER postgres

# Đặt lệnh chạy Patroni
CMD /patroni-venv/bin/patroni /etc/patroni.yml
