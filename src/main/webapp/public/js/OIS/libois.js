function libOIS (spec) {
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

libOIS.init = function (host, epgId) {
    return new libOIS({
        host: host
    });
};

libOIS.prototype.login = function (user, password, obj, callback) {
    if (!user) {
        if (typeof callback === 'function') callback(401, 'username are required!!');
            return;
    }
    password = (password == null) ? '' : password;
    var url = 'user/login';
    var terminal_id = '';
    var terminal_type = '';
    var mac = '';
    var netmode = '';
    var soft_ver = '';
    var hard_ver = '';
    var epg = '';
    var type = ''; //登录类型 0-用户id/email/mobile方式登陆，1-微信登陆，2-QQ登陆，3-新浪微博登陆
    var nickname = '';
    if (obj != null) {
        if (obj.terminal_type != null)
            terminal_type = obj.terminal_type;
        if (obj.terminal_id != null)
            terminal_id = obj.terminal_id;
        if (obj.mac != null)
            mac = obj.mac;
        if (obj.netmode != null)
            netmode = obj.netmode;
        if (obj.soft_ver != null)
            soft_ver = obj.soft_ver;
        if (obj.hard_ver != null)
            hard_ver = obj.hard_ver;
        if (obj.epg != null)
            epg = obj.epg;
        if (obj.nickname != null)
            nickname = obj.nickname;
        if (obj.type != null)
            type = obj.type;
    }
    var body = '<?xml version="1.0" encoding="utf-8"?>';
    body += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="default" SOAP-ENV:encodingStyle="default">';
    body += '<SOAP-ENV:Body>';
    body += '<login user="' + user + '" type="' + type + '" password="' + password + '" nickname="' + nickname + '" terminal_id="' + terminal_id + '"  terminal_type="' + terminal_type + '" mac="' + mac + '" netmode="' + netmode +'" soft_ver="' + soft_ver + '" hard_ver="' + soft_ver + '" epg="' + epg + '" />';
    body += '</SOAP-ENV:Body>';
    body += '</SOAP-ENV:Envelope>';
    this.send(url, body, callback);
};

libOIS.prototype.wxPay = function (user, obj, callback){

    if (user == null) {
        if (typeof callback === 'function') callback(401, 'user are required!!');
            return;
    }
    var url = 'wx/app/buy';
    var sid = '';
    var utc = '';
    var renew = '';
    var token = '';
    var desc = '';

    if (obj != null) {
        if (obj.sid != null)
            sid = obj.sid;
        if (obj.renew != null)
            renew = obj.renew;
        if (obj.token != null)
            token = obj.token;
        if (obj.desc != null)
            desc = obj.desc;
        if (obj.utc != null)
            utc = obj.utc;
    }

    var xmlStr = '<?xml version="1.0" encoding="utf-8"?>';
    xmlStr += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="default" SOAP-ENV:encodingStyle="default">';
    xmlStr += '<SOAP-ENV:Body>';
    xmlStr += '<wxPay user="' + user + '" sid="' + sid + '" start_utc="' +　utc +　'" renew="' + renew + '" token="' + token + '" desc="' + desc + '"/>';
    xmlStr += '</SOAP-ENV:Body>';
    xmlStr += '</SOAP-ENV:Envelope>';
    this.send(url, xmlStr, callback);
};

libOIS.prototype.wxJsApi = function (openid, obj, callback){
    if (openid == null) {
        if (typeof callback === 'function') callback(401, 'openid are required!!');
            return;
    }
    var user = '';
    var sid = '';
    var start_utc = new Date().getTime();
    var renew = '';
    var token = '';
    var desc = '';
    if (obj != null) {
        if (obj.user != null)
            user = obj.user;
        if (obj.sid != null)
            sid = obj.sid;
        if (obj.start_utc != null)
            start_utc = obj.start_utc;
        if (obj.renew != null)
            renew = obj.renew;
        if (obj.token != null)
            token = obj.token;
        if (obj.desc != null)
            desc = obj.desc;
        if (obj.token != null)
            token = obj.token;
    }
    var url = 'wx/jsapi/buy';
    var xmlStr = '<?xml version="1.0" encoding="utf-8"?>';
    xmlStr += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="default" SOAP-ENV:encodingStyle="default">';
    xmlStr += '<SOAP-ENV:Body>';
    xmlStr += '<wxpay user="' + user + '" sid="' + sid + '" start_utc="' + start_utc + '" renew="' + renew + '" token="' +  token + '" desc="' + desc + '"  openid="' + openid + '"/>';
    xmlStr += '</SOAP-ENV:Body>';
    xmlStr += '</SOAP-ENV:Envelope>';
    this.send(url, xmlStr, callback);
};

libOIS.prototype.orderRecords = function ( obj,token, callback) {
    var url = 'subscribe/list';
    var user = '';
    var type = ''; //登录类型 0-用户id/email/mobile方式登陆，1-微信登陆，2-QQ登陆，3-新浪微博登陆
    if (obj != null) {
        if (obj.user != null)
            user = obj.user;
        if (obj.type != null)
            type = obj.type;
    }
    var body = '<?xml version="1.0" encoding="utf-8"?>';
    body += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="default" SOAP-ENV:encodingStyle="default">';
    body += '<SOAP-ENV:Body>';
    body += '<subscribelist user="' + user + '" type="' + type + '" token="' + token + '"/>';
    body += '</SOAP-ENV:Body>';
    body += '</SOAP-ENV:Envelope>';
    this.send(url, body, callback);
};

libOIS.prototype.playAuthen = function ( obj,token, callback) {
    var url = 'play/authen';
    var user = '';
    var terminal_id = '';
    var media_id='';
    if (obj != null) {
        if (obj.user != null)
            user = obj.user;
        if (obj.terminal_id != null)
            terminal_id = obj.terminal_id;
        if (obj.media_id != null)
            media_id = obj.media_id;
    }
    var body = '<?xml version="1.0" encoding="utf-8"?>';
    body += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="default" SOAP-ENV:encodingStyle="default">';
    body += '<SOAP-ENV:Body>';
    body += '<authen user="'+user+'" terminal_id="'+terminal_id+'" media_id="'+media_id+'" token="'+token+'" />';
    body += '</SOAP-ENV:Body>';
    body += '</SOAP-ENV:Envelope>';
    this.send(url, body, callback);
};


/**
 * xml帮助类
 */
var XMLUtil = {
    loadXML:function(xmlString) {
        var xmlDoc = null;
        if (!window.DOMParser && window.ActiveXObject) {
            var xmlDomVersions = [ "MSXML.2.DOMDocument.6.0", "MSXML.2.DOMDocument.3.0", "Microsoft.XMLDOM" ];
            for (var i = 0; i < xmlDomVersions.length; i++) {
                try {
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString);
                    break;
                } catch (e) {}
            }
        } else if (window.DOMParser && document.implementation && document.implementation.createDocument) {
            try {
                domParser = new DOMParser();
                xmlDoc = domParser.parseFromString(xmlString, "text/xml");
            } catch (e) {}
        } else {
            return null;
        }
        return xmlDoc;
    },
    getAttributeValue:function(xmlNode, attrName) {
        if (!xmlNode) return "";
        if (!xmlNode.attributes) return "";
        if (xmlNode.attributes[attrName] != null) return xmlNode.attributes[attrName].value;
        if (xmlNode.attributes.getNamedItem(attrName) != null) return xmlNode.attributes.getNamedItem(attrName).value;
        return "";
    },
    getValueByName:function(xmlString, name){
        var start = xmlString.indexOf(name);
        if (start != -1) {

        }
    }
};