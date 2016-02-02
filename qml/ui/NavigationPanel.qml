import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Panel {
    id: panel
    property bool _userAvatarLock: false

    signal clicked
    signal userAvatarClicked

    onUserAvatarClicked: {
        toUserInfoPage();
    }

    function initUserAvatar() {

    }

    function reloadIndex(){
        toIndexPage();
    }

    Column {
        id: column
        spacing: Theme.paddingMedium
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        Item {
            id: userAvatar
            width: column.width
            height: cover.height
            BusyIndicator {
                id: avatarLoading
                anchors.centerIn: parent
                parent: userAvatar
                size: BusyIndicatorSize.Small
                opacity: avatarLoading.running ? 1 : 0
                running: cover.status != Image.Ready && profile.status != Image.Ready
            }
            Image {
                id: cover
                width: parent.width
                height: cover.width *2/3
                fillMode: Image.PreserveAspectCrop
                opacity: 0.6
                asynchronous: true
                source: "../pics/background.png"
                onStatusChanged: {
                    if (cover.status == Image.Ready) {
                        //util.saveRemoteImage(userInfoObject.usrInfo.cover_image_phone)
                    }
                }
            }
            Image {
                id: profile
                width: userAvatar.width/4
                height: width
                anchors.centerIn: cover
                asynchronous:true
                source: user.avatar
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("../pages/UserCenter.qml"));
                    }
                }
            }
            Label {
                id: screenName
                text: user.name
                anchors {
                    top: profile.bottom
                    topMargin: Theme.paddingSmall
                    horizontalCenter: profile.horizontalCenter
                }
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
            }
        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("News")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/news.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("../news/NewsList.qml"));
                }
            }
        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                id: atMeWeibo
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("Twitter")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/twitter.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("../twitter/TwitterList.qml"));
                }
            }

        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                id: atMeComment
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("Favorite")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/favorite.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("../favorite/FavoriteList.qml"));
                }
            }

        }

        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                id: sex
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("Blog")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/blog.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("../blog/BlogList.qml"));
                }
            }

        }
        Item {
            width: column.width
            height: Theme.itemSizeExtraSmall
            HorizontalIconTextButton {
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                text: qsTr("Settings")
                color: Theme.secondaryColor
                spacing: Theme.paddingMedium
                icon: "../pics/seeting.png"
                iconSize: Theme.itemSizeExtraSmall *2/3
                onClicked: {
                   pageStack.push(Qt.resolvedUrl("../pages/SettingPage.qml"));
                }
            }
        }
    }

}
