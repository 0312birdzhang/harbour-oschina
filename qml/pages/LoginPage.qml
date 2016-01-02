
import QtQuick 2.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import Sailfish.Silica 1.0
import "../js/ApiMain.js" as JS
Page{
    id:user_center_main
    property string webviewurl
    anchors.fill: parent
    WebView{
        id: webLogin
        opacity: 1
        visible: true
        url:webviewurl
        //url:"https://www.oschina.net/action/oauth2/authorize?response_type=code&client_id=JKVsTvptpOX8sfbfvexQ&redirect_uri=https://www.oschina.net"
        anchors.fill: parent
        experimental.userAgent:"Qt; Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36  (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36"

        Behavior on opacity {
            NumberAnimation{duration: 300}
        }

        onLoadingChanged:{
            var weburl=url.toString();
            if(weburl.indexOf(JS.api_redirect) != -1 && weburl.indexOf("code=") != -1 ){
                Qt.inputMethod.hide()
                var parames = JS.parse_url(weburl);
                code=parames["code"]
                JS.reqToken(code);
                signalCenter.showMessage(qsTr("Login success!"));
                toIndexPage()
            }
            }
        //}

    }
    BusyIndicator {
        anchors.centerIn: parent
        running: webLogin.loading
        size: BusyIndicatorSize.Medium
    }
}
