window.dayjs.locale('vi');
window.dayjs.extend(window.dayjs_plugin_relativeTime)
var currentDateElements = document.getElementsByClassName("created-at");
for (var i = 0; i < currentDateElements.length; i++) {
    currentDateElements[i].textContent = window.dayjs(currentDateElements[i].textContent).fromNow();
}