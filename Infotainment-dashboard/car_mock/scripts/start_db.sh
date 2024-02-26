docker run \
  --name car_data \
  -e 'POSTGRES_USER=test_db_user' \
  -e 'POSTGRES_PASSWORD=test_password' \
  -p '55432:5432' \
  -v local_db_data:/var/lib/postgresql/data \
  --restart unless-stopped \
  -d postgres
