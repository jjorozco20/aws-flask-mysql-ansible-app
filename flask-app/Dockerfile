# Use an official Python runtime as a parent image
FROM python:3.9-slim
# Set the working directory in the container
WORKDIR /src
# Copy the current directory contents into the container at /src/
COPY ./src /src
# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
# Make port 5000 available to the world outside this container
EXPOSE 5000
# Define build arguments
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DB
# Define environment variables
ENV MYSQL_USER=$MYSQL_USER \
    MYSQL_PASSWORD=$MYSQL_PASSWORD \
    MYSQL_HOST=host.docker.internal \
    MYSQL_DB=$MYSQL_DB
# Run app.py when the container launches
CMD ["python", "app.py"]
