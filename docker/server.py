"""Serve a tiny demo application with health and Prometheus-style metrics endpoints."""

from http import HTTPStatus
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path


INDEX_HTML = Path("/app/index.html").read_text(encoding="utf-8")


class RequestHandler(BaseHTTPRequestHandler):
    """Handle a small set of endpoints used by the Kubernetes examples."""

    def _write_response(self, body: str, content_type: str, status: HTTPStatus = HTTPStatus.OK) -> None:
        payload = body.encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def do_GET(self) -> None:  # noqa: N802 - HTTP handler method name is defined by BaseHTTPRequestHandler.
        if self.path == "/":
            self._write_response(INDEX_HTML, "text/html; charset=utf-8")
            return

        if self.path == "/healthz":
            self._write_response("ok\n", "text/plain; charset=utf-8")
            return

        if self.path == "/metrics":
            metrics = (
                "# HELP demo_http_requests_total Total HTTP requests served by the demo app.\n"
                "# TYPE demo_http_requests_total counter\n"
                "demo_http_requests_total 1\n"
            )
            self._write_response(metrics, "text/plain; version=0.0.4; charset=utf-8")
            return

        self._write_response("not found\n", "text/plain; charset=utf-8", status=HTTPStatus.NOT_FOUND)

    def log_message(self, format: str, *args) -> None:  # noqa: A003 - inherited API name.
        # Silence access logs to keep the sample container output minimal during demos.
        return


if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", 8080), RequestHandler)
    server.serve_forever()
