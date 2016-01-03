.pragma library
Qt.include("ApiCore.js")
Qt.include("ApiCategory.js")
Qt.include("Storge.js")
var signalcenter;
function setsignalcenter(mycenter){
    signalcenter=mycenter;
}
function sendWebRequest(url, callback, method, postdata) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        switch(xmlhttp.readyState) {
        case xmlhttp.OPENED:signalcenter.loadStarted();break;
        case xmlhttp.HEADERS_RECEIVED:if (xmlhttp.status != 200)signalcenter.loadFailed(qsTr("connect error,code:")+xmlhttp.status+"  "+xmlhttp.statusText);break;
        case xmlhttp.DONE:if (xmlhttp.status == 200) {
                try {
                    callback(xmlhttp.responseText);
                    signalcenter.loadFinished();
                } catch(e) {
                    console.log(e)
                    signalcenter.loadFailed(qsTr("loading erro..."));
                }
            } else {
                signalcenter.loadFailed("");
            }
            break;
        }
    }
    if(method==="GET") {
        xmlhttp.open("GET",url);
        xmlhttp.send();
    }
    if(method==="POST") {
        xmlhttp.open("POST",url);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", postdata.length);
        xmlhttp.send(postdata);
    }
}

//浏览器auth认证
var webviewUrl = api_url+oauth2_authorize+"?response_type=code&client_id="+api_id+"&redirect_uri="+api_redirect+"&state=xyz"

function parse_url(_url){ //定义函数
     var pattern = /(\w+)=(\w+)/ig;//定义正则表达式
     var parames = {};//定义数组
     _url.replace(pattern, function(a, b, c){parames[b] = c;});
    /*这是最关键的.当replace匹配到classid=9时.那么就用执行function(a,b,c);其中a的值为:classid=9,b的值为classid,c的值为9;(这是反向引用.因为在定义
      正则表达式的时候有两个子匹配.)然后将数组的key为classid的值赋为9;然后完成.再继续匹配到id=2;
      此时执行function(a,b,c);其中a的值为:id=2,b的值为id,c的值为2;然后将数组的key为id的值赋为2.
      from:http://blog.csdn.net/openn/article/details/8793457
    */
     return parames;//返回这个数组.
}
var application;
//登录二次认证
function reqToken(code){
    var url = api_url+oauth2_token+"?client_id="+api_id+"&grant_type=authorization_code&client_secret="+api_securet+"&redirect_uri="+api_redirect+"&code="+code;
    console.log("ReqToken:"+url);
    sendWebRequest(url,getToken,"GET","");
}
function getToken(oritxt){
    console.log("json:"+oritxt)
    var obj=JSON.parse(oritxt);
    if(obj.error){
        signalcenter.loadFailed(obj.error_description);
    }else{
        var access_token = obj.access_token;
        var refresh_token = obj.refresh_token;
        var token_type = obj.token_type;
        var expires_in = obj.expires_in;
        var uid = obj.uid;

        application.access_token = access_token;
        application.refresh_token = refresh_token;
        application.token_type = token_type;
        application.expires_in = expires_in;
        application.uid = uid;

        var userData = {
            "access_token":access_token,
            "refresh_token":refresh_token,
            "token_type":token_type,
            "expires_in":expires_in,
            "uid":uid,
            "savetime":parseInt(new Date().getTime()/1000)
        }
        signalcenter.loginSuccessed();
        getCurrentUser();
        application.saveAuthData(JSON.stringify(userData))
    }


}

function getCurrentUser(){
    var url = api_url + openapi_user + "?access_token="+application.access_token + "&dataType=json";
    sendWebRequest(url,loadCurrentUser,"GET","");
}

function loadCurrentUser(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.error){
        signalcenter.loadFailed(obj.error_description);
    }else{
        /*
        {
            id: 899**,
            email: "****@gmail.com",
            name: "彭博",
            gender: "male",
            avatar: "http://www.oschina.net/uploads/user/****",
            location: "广东 深圳",
            url: "http://home.oschina.net/****"
        }
        */
        application.user._id = obj.id;
        application.user.email = obj.email;
        application.user.name = obj.name;
        application.user.gender = obj.gender;
        application.user.avatar = obj.avatar;
        application.user.location = obj.location;
        application.user.url = obj.url;
    }
}

var listmodel;
function getlist(type){
    var url=api_url+type;
    sendWebRequest(url,loadlist,"POST","");
}


function loadlist(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success == "true"){
        listmodel.clear();
    }
    for(var i in obj.tngou){

        listmodel.append(obj.tngou[i]);
    }
    signalcenter.loadFinished();
}


var detailmodel;
function getdetail(type){
    var url=api_url+type;
    sendWebRequest(url,loaddetail,"GET","");
}
function loaddetail(oritxt){
    var obj=JSON.parse(oritxt);
    //if(obj.success){
        detailmodel.clear()
        detailmodel.append(obj)
    //}
    signalcenter.loadFinished();
}

var showmodel;
function getshow(type){
    var url=api_url+type;
    sendWebRequest(url,loadshow,"GET","");
}
function loadshow(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success ==="true"){
        showmodel.clear();
    }
    for(var i in obj.tngou){
        showmodel.append(obj.tngou[i]);
    }
}

var cookmessage;
var cooktag;
function getcookdetail(cookid){
         var url =api_url+"/cook/show?id="+cookid;
         sendWebRequest(url,loadcookdetail,"GET","");
    }
function loadcookdetail(oritxt){
         var obj=JSON.parse(oritxt);
         cookmessage=obj.tngou.message;
         cooktag = obj.tngou.tag;
         signalcenter.loadFinished();
        }

//分类
var catemodel;
function getcate(type){
    var url=api_url+type;
    sendWebRequest(url,loadcate,"GET","");
}
function loadcate(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success == "true"){
        catemodel.clear();
    }
    for(var i in obj){
        catemodel.append(obj[i]);
    }
}

//健康一问
var askdetailmodel;
function getanswer(type){
    var url=api_url+type;
    sendWebRequest(url,loadanswer,"GET","");
}
function loadanswer(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success == "true"){
        askdetailmodel.clear();
    }
    for(var i in obj.tngou.answer){
        askdetailmodel.append(obj.tngou.answer[i]);
    }
}

//美女图片,单独api
var sexapi = "http://www.tngou.net/tnfs/api/"

var sexlistmodel;
function getsexlist(type){
    var url=sexapi+type;
    sendWebRequest(url,loadsexlist,"POST","");
}
function loadsexlist(oritxt){
    var obj=JSON.parse(oritxt);

    for(var i in obj.tngou){
        sexlistmodel.append(obj.tngou[i]);
    }
    signalcenter.loadFinished();
}

var sexdetailmodel;
function getsexdetail(type){
    var url=sexapi+type;
    sendWebRequest(url,loadsexdetail,"GET","");
}
function loadsexdetail(oritxt){
    var obj=JSON.parse(oritxt);

    sexdetailmodel.clear()

    for(var i in obj.list){
        sexdetailmodel.append(obj.list[i]);
    }
    signalcenter.loadFinished();
}


