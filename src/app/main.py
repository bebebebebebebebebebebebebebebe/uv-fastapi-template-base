from fastapi import FastAPI

from src.utils.logger import get_logger

logger = get_logger(__name__)
app = FastAPI()


@app.get("/")
async def root():
    response = {"message": "Hello World"}
    logger.info(response)
    return response
