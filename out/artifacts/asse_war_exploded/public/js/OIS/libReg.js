/**
 * Created by ThinkPad on 2016/7/4.
 */
function libReg (spec) {
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
        //console.log(body);
        //console.log(url);
        req.open('POST', url, true);
        if (body) {
            //req.setRequestHeader('Content-Type', 'text/xml');
            req.send(body);
        } else {
            req.send();
        }
    };
}

libReg.init = function (host, epgId) {
    return new libReg({
        host: host
    });
};

libReg.prototype.reg = function (user, password,realname,email,mobile,obj,callback) {
    if (!user) {
        if (typeof callback === 'function') callback(401, 'username are required!!');
        return;
    }
    password = (password == null) ? '' : password;
    var url = 'user/register';
    var rel = encodeURI(realname);
    var body = '<?xml version="1.0" encoding="utf-8"?>';
    body += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="default" SOAP-ENV:encodingStyle="default">';
    body += '<SOAP-ENV:Body>';
    body += '<register user="' + user + '" password="' + password + '" realname="' + rel + '" country="xxx" postcode="xxx" email="' + email + '" addr="xxx" phone="xxx" mobile="' + mobile
        + '" birthday="xxx" enable="false" level="0" expperiod="30" sid="PALL_1M" channel="tvb"/>';
    body += '</SOAP-ENV:Body>';
    body += '</SOAP-ENV:Envelope>';
    console.log(body);
    this.send(url, body, callback);
};