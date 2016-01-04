.pragma library
var api_url="https://www.oschina.net";
var api_id = "JKVsTvptpOX8sfbfvexQ";
var api_securet = "BhzbAW8Q5ZgUZmqfcg8Sf3WMd4GM94ze";
var api_redirect = "https://client.example.com/cb";

function substr(string,length){
         string.toString();
         string.substr(0,length);
         return string;
        }

function humanedate(datestr){
    var _dateline = new Date(datestr).getTime();
    var thatday=new Date(parseInt(_dateline));
    var now=parseInt(new Date().valueOf());
    var cha=(now-_dateline)/1000;
    if(cha<180){
        return "刚刚";
    }else if(cha<3600){
        return Math.floor(cha/60)+" 分钟前";
    }else if(cha<86400){
        return Math.floor(cha/3600)+" 小时前";
    }else if(cha<172800){
        return "昨天 "+Qt.formatDateTime(thatday,"hh")+':'+Qt.formatDateTime(thatday,"mm");
    }else if(cha<259200){
        return "前天 "+Qt.formatDateTime(thatday,"hh")+':'+Qt.formatDateTime(thatday,"mm");
    }else if(cha<345600){
        return Math.floor(cha/86400)+" 天前";
    }else{
        return thatday.getFullYear()+'-'+(thatday.getMonth()+1)+'-'+thatday.getDate();
    }
}
