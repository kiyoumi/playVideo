function epgArea (spec) {
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/area/'
    this.send = function (url, body, callback) { // callback (err, resp)
        var epgId = this.id;
        var host = this.host;

        if(!host) {
            if (typeof callback === 'function') callback(401, 'host are required!!');
            return;
        }
        var url = this.url + url;

        var req = new XMLHttpRequest();
        req.onreadystatechange = function () {
            if (req.readyState == '4') {
                switch (req.status) {
                case 100:
                case 200:
                case 201:
                case 202:
                case 203:
                case 204:
                case 205:
                    if (typeof callback === 'function') callback(null, req.responseText);
                    break;
                default:
                    if (typeof callback === 'function') callback(req.status, req.responseText);
                }
            }
        };
        req.open('GET', url, true);
        if (body) {
            req.setRequestHeader('Content-Type', 'application/json');
            req.send(JSON.stringify(body));
        } else {
            req.send();
        }
    };
}

epgArea.init = function (host) {
    return new epgArea({
        host: host
    });
};

epgArea.prototype.get = function (token, obj, callback) {
    var url = 'get?token=' + token;
    if (obj != null) {
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
    }
    this.send(url, null,callback);
};