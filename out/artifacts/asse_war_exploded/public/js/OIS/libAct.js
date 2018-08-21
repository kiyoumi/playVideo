/**
 * Created by ThinkPad on 2016/7/4.
 */
function libAct (spec) {
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/ois/';
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
                console.log(req.getAllResponseHeaders());
                switch (req.status) {
                    case 100:
                    case 200:
                    case 201:
                    case 202:
                    case 203:
                    case 204:
                    case 205:
                        if (typeof callback === 'function') callback(req.status, req.responseText);
                        break;
                    default:
                        if (typeof callback === 'function') callback(req.status, req.responseText);
                }
            }
        };

        req.open('POST', url, true);
        if (body) {
            req.send(body);
        } else {
            req.send();
        }
    };
}

libAct.init = function (host, epgId) {
    return new libAct({
        host: host
    });
};

libAct.prototype.act = function (user, obj, callback) {
    if (!user) {
        if (typeof callback === 'function') callback(401, 'username are required!!');
        return;
    }
    var url = 'user/enable';
    var body = '<?xml version="1.0" encoding="utf-8"?>';
    body += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="default" SOAP-ENV:encodingStyle="default">';
    body += '<SOAP-ENV:Body>';
    body += '<enable user="'+user+'" />';
    body += '</SOAP-ENV:Body>';
    body += '</SOAP-ENV:Envelope>';
    this.send(url, body, callback);
};