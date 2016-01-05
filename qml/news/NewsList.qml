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
import "../js/ApiMain.js" as JS
Page {
    id: page
    property alias contentItem:filick
    property int newstype:2//1-所有|2-综合新闻|3-软件更新
    property int pageIndex:1
    function refresh(){
    }
    ListModel{
        id:newslitModel
    }
    SilicaFlickable {
        id:filick
        anchors.fill: parent
        PullDownMenu{
            MenuItem{
                text: newstype == 2?qsTr("NewsList"):
                                     (newstype == 3?qsTr("SoftNews"):qsTr("AllNews"))
                onClicked: {
                    if(newstype == 2){
                        newstype = 3;
                    }else if(newstype == 3){
                        newstype = 1;
                    }else{
                        newstype = 2;
                    }
                    JS.getnewslist(newstype,pageIndex)
                }
            }
        }

        SilicaListView {
            id: listView
            model: newslitModel
            anchors.fill: parent
            header: PageHeader {
                title:newstype == 2?qsTr("AllNews"):
                                     (newstype == 3?qsTr("SoftNews"):qsTr("NewsList"))
            }

            delegate: BackgroundItem {
                id: delegate
                contentHeight: newstitle.height + authorLabel.height + Theme.paddingMedium
                height: contentHeight
                width: parent.width
                Label {
                    id:newstitle
                    text:title
                    anchors{
                        top:parent.top
                        left:parent.left
                        leftMargin: Theme.paddingSmall
                        rightMargin: Theme.paddingSmall
                    }
                    opacity: 0.9
                    width: parent.width
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                    font.pixelSize: Theme.fontSizeMedium
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Label{
                    id:authorLabel
                    text:author
                    font.pixelSize: Theme.fontSizeExtraSmall
                    anchors{
                        top:newstitle.bottom
                        left:parent.left
                        leftMargin: Theme.paddingSmall
                    }
                    color:Theme.highlightColor
                    opacity: 0.8

                }
                Label{
                    id:timeLabel
                    text:JS.humanedate(pubDate)
                    font.pixelSize: Theme.fontSizeExtraSmall
                    anchors{
                        top:newstitle.bottom
                        right:parent.right
                        rightMargin: Theme.paddingSmall
                    }
                    color:Theme.highlightColor
                    opacity: 0.8

                }
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("NewsDetail.qml"),
                                   {
                                       "newsid":id
                                   })
                }
            }
            VerticalScrollDecorator {}
            footer:Component{
                Item {
                    id: loadMoreID
                    anchors {
                        left: parent.left;
                        right: parent.right;
                    }
                    height: Theme.itemSizeMedium
                    Row {
                        id:footItem
                        spacing: Theme.paddingLarge
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            text: qsTr("Prev Page")
                            visible: pageIndex > 1
                            onClicked: {
                                pageIndex--;
                                JS.getnewslist(newstype,pageIndex)
                                listView.scrollToTop()
                            }
                        }
                        Button{
                            text:qsTr("Next Page")
                            visible:true
                            onClicked: {
                                pageIndex++;
                                JS.getnewslist(newstype,pageIndex);
                                listView.scrollToTop()
                            }
                        }
                    }
                }

            }
            ViewPlaceholder{
                enabled: listView.count == 0
                text: "No items yet"
            }

        }
    }

    Component.onCompleted: {
        JS.newslistmodel = newslitModel;
        JS.getnewslist(newstype,pageIndex)
    }
}





