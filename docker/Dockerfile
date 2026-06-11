# Use a slim Python base image so the demo workload can expose health and metrics endpoints.
FROM python:3.12-alpine

# Copy the lightweight web server and static landing page into the image.
WORKDIR /app
COPY server.py /app/server.py
COPY index.html /app/index.html
RUN adduser -D -u 10001 appuser && chown -R appuser:appuser /app

# Expose the application port expected by the Kubernetes manifests.
EXPOSE 8080

# Start the demo application.
USER appuser
CMD ["python", "/app/server.py"]
