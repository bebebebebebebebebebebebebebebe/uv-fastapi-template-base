from src.utils.logger import get_logger
from typing_extensions import TypedDict

logger = get_logger(__name__)


class BaseFomatData(TypedDict):
    timestamp: str
    level: str
    message: str
    module: str
    function: str
    line: int


def test_logger():
    logger.info("Test log message")
