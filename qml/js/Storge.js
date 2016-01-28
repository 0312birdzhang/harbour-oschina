.import QtQuick.LocalStorage 2.0 as SQL

function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("oschina", "1.0", "oschina for sailfish", 10000);
}


// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
        function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS token(value text);');

        });
}

var token;

// 获取token
function getAuthData() {
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM token;');
        if (rs.rows.length > 0) {
            token= rs.rows.item(0).value;
        }
        else{
        }
    });

    return token;
}


//保存token
function saveAuthData(token) {
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('insert or replace into token values(?);', [token]);
        if(rs.rowsAffected > 0 ){
            console.log("rowsAffected");
        }
    });
}

function clearAuthData(){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from token;');
    });
}
