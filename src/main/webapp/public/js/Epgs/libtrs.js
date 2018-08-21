function TRS (spec) {
    this.host = spec.host;
    this.url = 'http://' + spec.host;
    this.trsAddr = '';
    this.stbId = '';
    this.send = function (u, body, b, callback) { // callback (err, resp)
        var host = this.host;

        if(!host) {
            if (typeof callback === 'function') callback(401, 'host are required!!');
            return;
        }
        var url = '';
        if (b) {
            url = 'http://' + this.trsAddr + u;
        } else {
            url = this.url + u;
        }
        console.log(url);
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
                    if (typeof callback === 'function') callback(req.status, req.responseText);
                    break;
                default:
                    if (typeof callback === 'function') callback(req.status, req.responseText);
                }
            }
        };
        //console.log(url);
        if (body) {
            //console.log('POST');
            req.open('POST', url, true);
            //req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            req.send(JSON.stringify(body));
        } else {
            //console.log('GET');
            req.open('GET', url, true);
            req.send();
        }
    };
}

//XmlHttpRequest对象    
function createXmlHttpRequest(){    
    if(window.ActiveXObject){ //如果是IE浏览器    
        return new ActiveXObject("Microsoft.XMLHTTP");    
    }else if(window.XMLHttpRequest){ //非IE浏览器    
        return new XMLHttpRequest();    
    }    
}   

TRS.init = function (host) {
    return new TRS({
        host: host
    });
};

TRS.prototype.getServer = function (phoneid, callback) {
    var url = '/GetServer/phone?phoneid=' + phoneid;
    this.send(url, null, false, callback);
};

TRS.prototype.screen = function (body, callback){
    var url = '/phone/screen';
    this.send(url, body, true, callback);
}

TRS.prototype.getStbid = function (phoneid, callback){
    var url = '/phone/GetStbid?phoneid=' + phoneid;
    this.send(url, null, false, callback);
}

TRS.prototype.transferMsg = function(body, callback){
    //{“id”:”111”, “recid”:”222”}
    var url = '/transfermsgPost';
    this.send(url, body, true, callback);
}

/*TRS.prototype.bindStb = function (phoneid, stbid, callback) {
    var url = '/phone/bindStb';
    var body = {phoneid:phoneid, stbid:stbid};
    this.send(url, body, callback);
};*/