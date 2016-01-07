import QtQuick 2.0
import "../js/ApiMain.js" as JS
import Sailfish.Silica 1.0
Page{
    id:detail
    property int newsid
    ListModel{
        id:detailModel
    }

    SilicaFlickable{
        id:filick
        anchors.fill: parent
        contentHeight: column

        Column{
            id:column
            Label{
                id:titlelabel
                text:detailModel.title
                anchors{
                    left:parent.left
                    right:parent.right
                    top:parent.top
                }
            }
            Label{
                id:bodylabel
                text:detailModel.body
                anchors{
                    top:titlelabel.bottom
                    left:parent.left
                    right:parent.right
                    margins: Theme.paddingMedium
                }

            }


        }

    }

    Component.onCompleted: {
        JS.detailmodel = detailModel
        JS.getdetail(newsid)
    }
}

