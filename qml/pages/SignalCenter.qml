import QtQuick 2.0
import Sailfish.Silica 1.0
QtObject{
    id:signalcenter;
    signal loadStarted;
    signal loadFinished;
    signal loadFailed(string errorstring);
    signal loginSuccessed;
    signal loginFailed(string errorstring);
    signal dlInfoSetted;
    signal fileHashGeted;
    signal versionGeted;
    signal commentSendSuccessful;
    signal commentSendFailed(string errorstring);
    signal toLoginpage;
    signal toIndexpage;
    function showMessage(msg) {
        if (msg||false) {
           showMsg(msg)
        }
    }
}
