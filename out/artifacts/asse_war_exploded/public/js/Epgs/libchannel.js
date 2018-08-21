function epgChannel (spec) {
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/channel/epg/'
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

epgChannel.init = function (host, epgId) {
    return new epgChannel({
        host: host
    });
};

epgChannel.prototype.get = function (id, token, obj, callback) {
    var url = 'get?id=' + id + '&token=' + token;
    if (obj != null) {
        if (obj.date != null)
            url += ('&date=' + obj.date);
        if (obj.timezone != null)
            url += ('&timezone=' + obj.timezone);
        if (obj.days != null)
            url += ('&days=' + obj.days);
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
        if (obj.utc != null)
            url += ('&utc=' + obj.utc);
        if (obj.endutc != null)
            url += ('&endutc=' + obj.endutc);
    }
    this.send(url, null, callback);
};

epgChannel.prototype.sync = function (token, callback){
    var url = 'sync?token=' + token;
    this.send(url, null,callback);
}