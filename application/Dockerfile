# Use the official Python image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the script to the working directory
COPY start-webserver.sh .

# Make the script executable
RUN chmod +x ./start-webserver.sh

# Expose port 8000
EXPOSE 8000

# Run the script when the container starts
CMD ["./start-webserver.sh"]