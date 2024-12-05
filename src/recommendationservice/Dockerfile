

FROM python:3.12.6-slim@sha256:ad48727987b259854d52241fac3bc633574364867b8e20aec305e6e7f4028b26 AS base

FROM base AS builder

RUN apt-get -qq update \
    && apt-get install -y --no-install-recommends \
        wget g++ \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -r requirements.txt

FROM base

ENV PYTHONUNBUFFERED=1

WORKDIR /recommendationservice


COPY --from=builder /usr/local/lib/python3.12/ /usr/local/lib/python3.12/

COPY . .

ENV PORT "8080"
EXPOSE 8080

ENTRYPOINT ["python", "recommendation_server.py"]
