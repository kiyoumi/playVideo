function epgColumn (spec) {
    this.id = spec.epgId;
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/' + spec.epgId + '/column/'
    this.send = function (url, body, callback) { // callback (err, resp)
        var epgId = this.id;
        var host = this.host;

        if(!epgId || !host) {
            if (typeof callback === 'function') callback(401, 'epgId and host are required!!');
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

epgColumn.init = function (host, epgId) {
    return new epgColumn({
        epgId: epgId,
        host: host
    });
};

epgColumn.prototype.get = function (pid, token, obj, callback) {
    var url = 'get?pid=' + pid + '&token=' + token;
    if (obj != null) {
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
    }
    this.send(url, null, callback);
};

epgColumn.prototype.list = function (token, obj, callback){
    var url = 'list?token=' + token;
    if (obj != null) {
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
    }
    this.send(url, null,callback);
}

/*epgColumn.prototype.product = function (token, obj, callback){
    var url = 'product/content?token=' + token;
    if (obj != null) {
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
    }
    this.send(url, null,callback);
}*/

epgColumn.prototype.map = function (token, obj, callback){
    var url = 'map?token=' + token;
    if (obj != null) {
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
    }
    this.send(url, null,callback);
}

epgColumn.prototype.info = function (token, id, callback){
    var url = 'info?token=' + token + '&id=' + id;
    this.send(url, null,callback);
}