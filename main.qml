import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 400
    title: "Clock"
    /*flags: Qt.FramelessWindowHint | Qt.Window*/
    property var hms: {'hours': 0, 'minutes': 0, 'seconds': 0 }
    property QtObject backend

    color: "transparent"


    Image {
        id: clockface
        sourceSize.width: parent.width
        fillMode: Image.PreserveAspectFit
        source: "./images/clockface.png"

        Image {
            x: parent.width/2 - width/2
            y: parent.height/2 - height/2
            scale: parent.height/835
            source: "./images/hour.png"
            transform: Rotation {
                    origin.x: 73; origin.y: 211;
                    angle: (hms.hours * 30) + (hms.minutes * 0.5)
            }
        }

        Image {
            x: parent.width/2 - width/2
            y: parent.height/2 - height/2
            source: "./images/minute.png"
            scale: parent.height/835
            transform: Rotation {
                    origin.x: 40.5; origin.y: 287.5;
                    angle: hms.minutes * 6
                    Behavior on angle {
                        SpringAnimation { spring: 1; damping: 0.2; modulus: 360 }
                    }
                }
        }

        Image {
            x: parent.width/2 - width/2
            y: parent.height/2 - height/2
            source: "./images/second.png"
            scale: parent.height/835
            transform: Rotation {
                    origin.x: 41; origin.y: 300;
                    angle: hms.seconds * 6
                    Behavior on angle {
                        SpringAnimation { spring: 3; damping: 0.2; modulus: 360 }
                    }
                }
        }

    }

    Connections {
        target: backend

        function onHms(hours, minutes, seconds) {
            hms = {'hours': hours, 'minutes': minutes, 'seconds': seconds }
        }
    }

}