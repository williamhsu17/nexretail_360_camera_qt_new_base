import sys

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QTimer, QObject, pyqtSignal

from time import localtime

app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('main.qml')


class Backend(QObject):

    hms = pyqtSignal(int, int, int, arguments=['hours', 'minutes', 'seconds'])

    def __init__(self):
        super().__init__()

        # Do not use python timer, may causing QT threading issues, on UI
        self.timer = QTimer()
        self.timer.setInterval(100)  # msecs 100 = 1/10th sec
        self.timer.timeout.connect(self.update_time)
        self.timer.start()

    def update_time(self):
        # Pass the current time to QML.
        time = localtime()
        self.hms.emit(time.tm_hour, time.tm_min, time.tm_sec)


# Construct backend object and pass to QML.
backend = Backend()
engine.rootObjects()[0].setProperty('backend', backend)

sys.exit(app.exec())
