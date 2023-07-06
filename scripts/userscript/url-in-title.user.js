// ==UserScript==
// @name        URL in title
// @description Add URL to your page title. (Usefull for KeePass, Rofi)
// @author      DDoSolitary
// @version     0.1.1
// @updateURL   https://openuserjs.org/meta/DDoSolitary/URL_in_Title.meta.js
// @match       *://*/*
// @run-at      document-start
// @grant       none
// ==/UserScript==

(function() {
    var lastPrefix = null;
    var addUrlPrefix = function() {
        if (document.getElementsByTagName('title').length === 0) return;
        var urlPrefix = location.host + ' |';
        var title = document.title;
        if (!title.startsWith(urlPrefix)) {
            if (lastPrefix !== null && title.startsWith(lastPrefix)) {
                title = title.substring(title.length - 1, title.length + lastPrefix.length - 1);
            }
            lastPrefix = urlPrefix;
            document.title = urlPrefix + ' ' + title;
        }
    };
    addUrlPrefix();
    setInterval(addUrlPrefix, 250);
})();
