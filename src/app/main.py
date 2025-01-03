from fastapi import FastAPI

from utils.logger import get_logger

logger = get_logger(__name__)
app = FastAPI()


@app.get("/")
async def root():
    response = {"message": "Hello World"}
    logger.info(response)
    return response


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
