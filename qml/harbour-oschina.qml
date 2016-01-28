/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import org.nemomobile.notifications 1.0
import "pages"
import "components"
import "ui"
import "model"
import "news"
import "js/ApiMain.js" as Main
import "js/Storge.js" as Settings
ApplicationWindow
{

    id:applicationWindow
    property int openimg:-1
    property Page currentPage: pageStack.currentPage
    property string currentclass: "medical"
    property string access_token;
    property string refresh_token;
    property string token_type;
    property int expires_in;
    property string uid;
    property alias user:user
    property bool loading:false;
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    SignalCenter{
        id: signalCenter;
    }

    User{
        id:user
    }

    Timer{
        id:processingtimer;
        interval: 60000;
        onTriggered: signalcenter.loadFailed("error");
    }

    Notification{
     id:notification
     onClicked:{
         applicationWindow.activate()
     }
    }
    Connections{
            target: signalCenter;
            onLoadStarted:{
                applicationWindow.loading=true;
                processingtimer.restart();
            }
            onLoadFinished:{
                applicationWindow.loading=false;
                processingtimer.stop();
            }
            onLoadFailed:{
                applicationWindow.loading=false;
                processingtimer.stop();
                signalCenter.showMessage(errorstring);
            }
            onToIndexpage:{
              console.log("to indexpage signal")
              toIndexPage();
            }
            onToLoginpage:{
              toLoginPage()
            }
        }

    Component.onCompleted: {
        Main.setsignalcenter(signalCenter);
        Settings.initialize();
        Main.application = applicationWindow
    }


    function showMsg(message) {
        notification.previewBody = "Oschina";
        notification.previewSummary = message;
        notification.close()
        notification.publish();
    }
    ///////////// 登陆页面
    function toLoginPage() {
        popAttachedPages();
        pageStack.replace(loginPageComponent);
    }

    ///////////// 主页
    function toIndexPage() {
        popAttachedPages();
        pageStack.replace(indexPageComponent);

    }

    ////////// 用户个人中心
    function toUserInfoPage(){
        //
    }

    function getCurrentUser(){
        Main.getCurrentUser()
    }

    function popAttachedPages() {
        // find the first page
        var firstPage = pageStack.previousPage();
        if (!firstPage) {
            return;
        }
        while (pageStack.previousPage(firstPage)) {
            firstPage = pageStack.previousPage(firstPage);
        }
        // pop to first page
        pageStack.pop(firstPage);
    }

    function saveAuthData(data){
        Settings.clearAuthData();
        Settings.saveAuthData(data);
    }

    initialPage: Component {

        Page{
            Timer {
                id: timerDisplay
                running: true;
                repeat: false;
                triggeredOnStart: true
                interval: 2 * 1000
                onTriggered: {
                    //Settings.initialize();
                    //Main.application = applicationWindow
                    var savedtoken = Settings.getAuthData();
                    console.log("savedToken:"+savedtoken);
                    if(savedtoken){
                        var obj = JSON.parse(savedtoken);
                        var savetime = obj.savetime;
                        var currenttime = parseInt(new Date().getTime()/1000);
                        var expires_in = obj.expires_in;
                        if(currenttime >= savetime + expires_in){
                            toLoginPage();
                            return;
                        }
                        access_token = obj.access_token;
                        refresh_token = obj.refresh_token;
                        token_type = obj.token_type;
                        uid = obj.uid;
                        getCurrentUser();
                        toIndexPage();
                    }else{
                        toLoginPage()
                    }
                }
            }

        }

    }
        //主页列表显示
    Component {
        id: indexPageComponent
        FirstPage {
            id: indexPage
            //            property bool _settingsInitialized: false
            property bool _dataInitialized: false
            property bool withPanelView: true
            Binding {
                target: indexPage.contentItem
                property: "parent"
                value: indexPage.status === PageStatus.Active
                       ? (panelView .closed ? panelView : indexPage) //修正listview焦点
                       : indexPage
            }
            //            Component.onCompleted: {
            //                if (!_settingsInitialized) {
            //                    Settings.initialize();
            //                    _settingsInitialized = true;
            //                }
            //            }
            onStatusChanged: {
                if (indexPage.status === PageStatus.Active) {
                    //                    if (!tokenValid) {
                    //                        startLogin();
                    //                    } else {
                    if (!_dataInitialized) {
                        indexPage.refresh();
                        _dataInitialized = true;
                        //                        }
                    }
                }
            }
        }
    }

    Component{
        id:loginPageComponent
        LoginPage{
            id:loginPage
            webviewurl:Main.webviewUrl
        }
    }


    BusyIndicator {
        id:busyIndicator
        parent: applicationWindow.currentPage
        anchors.centerIn: parent
        z: 10
        size: BusyIndicatorSize.Large
        running:loading
        opacity: busyIndicator.running ? 1: 0
    }
    PanelView {
        id: panelView
        // a workaround to avoid TextAutoScroller picking up PanelView as an "outer"
        // flickable and doing undesired contentX adjustments (the right side panel
        // slides partially in) meanwhile typing/scrolling long TextEntry content
        property bool maximumFlickVelocity: false

        width: pageStack.currentPage.width
        panelWidth: Screen.width / 3 * 2
        panelHeight: pageStack.currentPage.height
        height: currentPage && currentPage.contentHeight || pageStack.currentPage.height
        visible:  (!!currentPage && !!currentPage.withPanelView) || !panelView.closed
        anchors.centerIn: parent
        //anchors.verticalCenterOffset:  -(panelHeight - height) / 2

        anchors.horizontalCenterOffset:  0

        Connections {
            target: pageStack
            onCurrentPageChanged: panelView.hidePanel()
        }

        function initUserAvatar() {
            leftPanel.initUserAvatar();
        }

        leftPanel: NavigationPanel {
            id: leftPanel
            busy: false //panelView.closed /*&& !!BufferModel.connections && BufferModel.connections.some(function (c) { return c.active && !c.connected })*/
            //            highlighted: MessageStorage.activeHighlights > 0
            onClicked: {
                panelView.hidePanel();
            }

            Component.onCompleted: {
                panelView.hidePanel();
            }
        }
    }

        Python{
            id:py
            Component.onCompleted: { // this action is triggered when the loading of this component is finished
            addImportPath(Qt.resolvedUrl('./py')); // adds import path to the directory of the Python script
            py.importModule('main', function () { // imports the Python module
            });
        }

        //注册保存方法
        function saveImg(basename,volname){
            call('main.saveImg',[basename,volname],function(result){
                return result
            })
        }
        //注册缓存方法
        function cacheImg(url,md5name){
            call('main.cacheImg',[url,md5name],function(result){
                //homepageImg = result;
                console.log("local path:"+result)
            })
            //return "image://theme/icon-m-refresh"
        }
        function clearCache(){
            call('main.clearImg',[],function(result){
                   return result
            })
        }

        //onError: signalCenter.showMessage(traceback)
        onReceived: {
            console.log('Event: ' + data);
            var sendMsg="";
            switch(data.toString()){
            case "1":
                sendMsg=qsTr("Successed saved to ~/Pictures/save/OSC/")
                break;
            case "-1":
                sendMsg=qsTr("Error")
                break;
            case "2":
                sendMsg=qsTr("Cleared")
                break;
            default:
                sendMsg=qsTr("Unknown")
            }

            signalCenter.showMessage(sendMsg)
        }
    }

    }
