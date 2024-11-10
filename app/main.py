from fastapi import FastAPI
from uvicorn import run
import multiprocessing


app = FastAPI()

@app.get("/")
def hello():
    return "Hello, World!"

if __name__ == '__main__':
    multiprocessing.freeze_support()  # For Windows support
    run(app, host="0.0.0.0", port=8081, reload=False, workers=1)