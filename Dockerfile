FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim AS requirements-stage

WORKDIR /tmp

RUN apt-get update && \
  apt-get -y install locales vim git libpq5 && \
  localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
  rm -rf /var/lib/apt/lists/*

ENV LANG=ja_JP.UTF-8 \
  LANGUAGE=ja_JP:ja \
  LC_ALL=ja_JP.UTF-8 \
  TZ=JST-9 \
  TERM=xterm

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

RUN --mount=type=cache,target=/root/.cache/uv \
  --mount=type=bind,source=uv.lock,target=uv.lock \
  --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
  uv sync --frozen --no-install-project --no-dev

ADD . /tmp
RUN --mount=type=cache,target=/root/.cache/uv \
  uv sync --frozen --no-dev

ENV PATH="/tmp/.venv/bin:$PATH"

CMD ["uvicorn", "src.app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
