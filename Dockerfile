FROM python:3.12-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
ADD --chmod=755 https://github.com/seal-community/cli/releases/download/latest/seal-linux-amd64-latest seal
ENV SEAL_PROJECT="python-template"
RUN --mount=type=secret,id=SEAL_TOKEN export SEAL_TOKEN=$(cat /run/secrets/SEAL_TOKEN) && ./seal fix --mode remote requirements.txt --remove-cli
CMD ["python", "app.py"]
