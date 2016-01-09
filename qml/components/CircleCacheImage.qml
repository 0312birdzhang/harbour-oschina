import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import com.stars.widgets 1.0

MyImage{
    id:thumbnail
    //asynchronous: true
    property string cacheurl
    Python{
        id:imgpy
         Component.onCompleted: {
         addImportPath('/usr/share/harbour-oschina/qml/py'); // adds import path to the directory of the Python script
         imgpy.importModule('main', function () {
                call('main.cacheImg',[cacheurl],function(result){
                    console.log("result:"+result)
                    if(!result){
                        thumbnail.source = "file:////usr/share/harbour-oschina/qml/pics/default_avatar.png"
                    }else{
                        thumbnail.source = "file:///"+result;
                    }

                     waitingIcon.visible = false;
                });
       })
      }
    }
    Image{
        id:waitingIcon
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        source: "image://theme/icon-m-refresh";
        //visible: parent.status==Image.Loading
    }
}
