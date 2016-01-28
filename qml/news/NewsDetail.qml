import QtQuick 2.0
import "../js/ApiMain.js" as JS
import Sailfish.Silica 1.0
Page{
    id:detail
    property string newsid
    property string detailapi
    property string title
    property string body
    property string pubDate
    property string authorid
    property int favorite
    property int commentCount
    property string url
    property string author

    SilicaFlickable{
        id:filick
        anchors.fill: parent
        contentHeight: header.height + bodylabel.height + authlabel.height + Theme.paddingLarge
        PageHeader{
            id:header
            title: detail.title
        }

        Label{
            id:authlabel
            text:qsTr("author:")+author
            color: Theme.secondaryHighlightColor
            anchors{
                right:parent.right
                top:header.bottom
                margins: Theme.paddingMedium
            }
        }
        Label{
            id:bodylabel
            text:detail.body
            wrapMode: Text.WordWrap
            linkColor:Theme.primaryColor
            font.letterSpacing: 2
            textFormat: Text.RichText
            font.pixelSize: Theme.fontSizeExtraSmall
            anchors{
                top:authlabel.bottom
                left:parent.left
                right:parent.right
                margins: Theme.paddingMedium
            }

        }
    }

    Component.onCompleted: {
        JS.detailpage = detail
        JS.getdetail(newsid,detailapi)
    }
}
