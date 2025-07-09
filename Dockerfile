FROM python:3.11-slim

# ตั้งค่าระบบ Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# ติดตั้ง dependency สำหรับ mysqlclient และ pip
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# กำหนด working directory
WORKDIR /app

# ก๊อป requirements.txt และติดตั้ง
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ก๊อปไฟล์ทั้งหมดในโปรเจกต์
COPY . .

# คำสั่งรัน server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
