docker-compose build --no-cache
docker create network proxy
docker-compose run --rm view npm install
docker-compose run --rm api rails db:create
docker-compose run --rm api rails db:migrate
docker-compose run --rm api rails db:seed_fu
