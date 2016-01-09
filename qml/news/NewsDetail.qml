import QtQuick 2.0
import "../js/ApiMain.js" as JS
import Sailfish.Silica 1.0
Page{
    id:detail
    property int newsid
    property string title
    property string body
    property string pubDate
    property string authorid
    property int favorite
    property int commentCount
    property string url

    ListModel{
        id:detailModel
    }

    SilicaFlickable{
        id:filick
        anchors.fill: parent
        contentHeight: titlelabel.height + bodylabel.height + Theme.paddingLarge
        Label{
            id:titlelabel
            text:title
            anchors{
                left:parent.left
                right:parent.right
                top:parent.top
            }
        }
        Label{
            id:bodylabel
            text:body
            anchors{
                top:titlelabel.bottom
                left:parent.left
                right:parent.right
                margins: Theme.paddingMedium
            }

        }




    }

    Component.onCompleted: {
        JS.detailpage = detail
        JS.getdetail(newsid)
    }
}

