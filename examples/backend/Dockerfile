# Choose a lightweight version of Python as your base
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies (needed for some Python libraries like those that process PDFs or images)
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Copy the list of libraries your app needs
COPY requirements.txt .

# Install the libraries
RUN pip install --no-cache-dir -r requirements.txt

# Copy your actual app code into the container
# We copy it into a folder named 'app' to match our import statements
COPY app/ /app/app/

# Tell the container which port to open (matches docker-compose)
EXPOSE 8000

# The command to start your app
# 'uvicorn' is the web server, 'app.main:app' points to your FastAPI instance
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
