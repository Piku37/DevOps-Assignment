# Import required modules
from flask import Flask, jsonify, request
from prometheus_client import make_wsgi_app, Counter, Histogram
from werkzeug.middleware.dispatcher import DispatcherMiddleware
import time

# Create Flask app
app = Flask(__name__)

# Attach Prometheus WSGI middleware for /metrics endpoint
app.wsgi_app = DispatcherMiddleware(app.wsgi_app, {
    '/metrics': make_wsgi_app()
})

# Define Prometheus metrics
REQUEST_COUNT = Counter(
    'app_request_count',
    'Application Request Count',
    ['method', 'endpoint', 'http_status']
)
REQUEST_LATENCY = Histogram(
    'app_request_latency_seconds',
    'Application Request Latency',
    ['method', 'endpoint']
)

# Define a sample route
@app.route('/')
def hello():
    start_time = time.time()  # Start timer
    response = jsonify(message='Hello, Liaplus AI!')  # Prepare response
    REQUEST_COUNT.labels('GET', '/', 200).inc()  # Increment request count
    REQUEST_LATENCY.labels('GET', '/').observe(time.time() - start_time)  # Record latency
    return response

# Run the Flask app
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
