FROM --platform=linux/amd64 python:3.12.4-slim@sha256:d3a32591680bdfd49da5773495730cf8afdb817e217435db66588b2c64db6d5e as base

FROM base as builder

COPY requirements.txt .

RUN pip install --prefix="/install" -r requirements.txt

FROM base

WORKDIR /loadgen

COPY --from=builder /install /usr/local


COPY locustfile.py .


ENV GEVENT_SUPPORT=True

ENTRYPOINT locust --host="http://${FRONTEND_ADDR}" --headless -u "${USERS:-10}" 2>&1