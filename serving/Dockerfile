FROM python:3-alpine

WORKDIR /app

COPY . .
RUN pip install --no-cache-dir -r requirements.txt

CMD ["fastapi", "run", "main.py"]
