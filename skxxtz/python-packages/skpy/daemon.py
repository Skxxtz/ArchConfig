import os
import sys
import atexit
import signal
import logging
from logging.handlers import RotatingFileHandler
import datetime
from .notify import notify

class Daemon:
    TIME_STARTED = datetime.datetime.now()

    def __init__(self, process_name) -> None:
        pid_file = f'/tmp/usr/{process_name}.pid'
        log_file = f'/tmp/usr/{process_name}.log'
        self.daemonize(pid_file)
        self.logger = self.setup_logging(log_file)
        self.logger.info("Daemon started")

    def setup_logging(self, log_file):
        logger = logging.getLogger()
        logger.setLevel(logging.INFO)
        handler = RotatingFileHandler(log_file, maxBytes=10*1024*1024, backupCount=5)
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        return logger


    def daemonize(self, pid_file):
        if os.fork() > 0:
            sys.exit(0)
        os.chdir('/')
        os.setsid()
        os.umask(0)
        if os.fork() > 0:
            sys.exit(0)

        sys.stdout.flush()
        sys.stderr.flush()
        with open('/dev/null', 'rb', 0) as f:
            os.dup2(f.fileno(), sys.stdin.fileno())
        with open('/dev/null', 'ab', 0) as f:
            os.dup2(f.fileno(), sys.stdout.fileno())
            os.dup2(f.fileno(), sys.stderr.fileno())

        with open(pid_file, 'w') as f:
            f.write(str(os.getpid()))

        atexit.register(lambda: os.remove(pid_file))
        signal.signal(signal.SIGTERM, lambda signum, frame: sys.exit(0))

    def exit(self, send_notification=False, title=None, body=None, app_name=None):
        self.logger.info("Daemon Stopped")
        if all([send_notification, title, body, app_name]):
            notify(title, body, app_name)
        sys.exit(0)
     
if __name__ == "__main__":
    pass
