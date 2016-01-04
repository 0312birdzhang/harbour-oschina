# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-oschina

CONFIG += sailfishapp

SOURCES += src/harbour-oschina.cpp

OTHER_FILES += qml/harbour-oschina.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-oschina.changes.in \
    rpm/harbour-oschina.spec \
    rpm/harbour-oschina.yaml \
    translations/*.ts \
    harbour-oschina.desktop \
    qml/pages/LoginPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-oschina-zh_CN.ts

DISTFILES += \
    qml/components/AppGridComponet.qml \
    qml/components/AppListComponet.qml \
    qml/components/CacheImage.qml \
    qml/components/HorizontalIconTextButton.qml \
    qml/components/ImagePage.qml \
    qml/components/LabelText.qml \
    qml/components/Panel.qml \
    qml/components/PanelView.qml \
    qml/components/UserAvatarHeader.qml \
    qml/js/ApiCore.js \
    qml/js/ApiMain.js \
    qml/js/md5.js \
    qml/js/Storge.js \
    qml/py/__init__.py \
    qml/py/basedir.py \
    qml/py/main.py \
    qml/js/ApiCategory.js \
    qml/pages/SignalCenter.qml \
    qml/ui/NavigationPanel.qml \
    qml/model/User.qml \
    qml/news/NewsList.qml

