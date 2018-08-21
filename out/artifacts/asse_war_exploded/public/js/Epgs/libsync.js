function epgSync (spec) {
    this.id = spec.epgId;
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/' + spec.epgId + '/sync/';
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
        //console.log(url);
        req.open('GET', url, true);
        if (body) {
            req.setRequestHeader('Content-Type', 'application/json');
            req.send(JSON.stringify(body));
        } else {
            req.send();
        }
    };
}

epgSync.init = function (host, epgId) {
    return new epgSync({
        epgId: epgId,
        host: host
    });
};

epgSync.prototype.get = function (columnid, token, callback) {
    columnid = (columnid == null) ? '' : columnid;
    var url = 'get?columnid=' + columnid + '&token=' + token;
    this.send(url, null, callback);
};

epgSync.prototype.map = function (token, callback){
    var url = 'map?token=' + token;
    this.send(url, null,callback);
}