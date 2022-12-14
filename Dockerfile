FROM python:3.10-slim

WORKDIR /opt/todolist

ENV PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_NO_CACHE_DIR=off \
    PYTHON_PATH=/opt/todolist \
    POETRY_VERSION=1.1.14

RUN apt-get update && apt-get install -y --no-install-recommends \
#    gcc \
    curl \
#    build-essential \
#    libpq-dev \
    && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/lists/* /tmp/* /var/tmp/* \
    && pip install "poetry==$POETRY_VERSION"

COPY poetry.lock .
COPY pyproject.toml .
RUN pip install poetry
# RUN poetry update

RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-dev

COPY source/ .
# CMD python manage.py runserver 0.0.0.0:8000 --settings=todolist.settings

# ENTRYPOINT ["bash", "entrypoint.sh"]