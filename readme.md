- Pastikan docker sudah terinstall
- Buat file .env (copy dari .env.example), sesuaikan isi value nya

### Cara menjalankan:

1. Pastikan image sudah ter-build:

```bash
docker build -t xendit-app .
```

2. Lalu jalankan:

```bash
docker compose up -d
```

3. Cek container berjalan:

```bash
docker ps
```

Aplikasi sudah berjalan di `localhost:8000`