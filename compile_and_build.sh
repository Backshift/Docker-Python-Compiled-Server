source .env
docker build -t $IMG_NAME -f Dockerfile .
docker run --rm -v "$(pwd)"/dist:/app/dist -w /app "$IMG_NAME" pyinstaller --onefile --name fast_bin -F /app/main.py --clean