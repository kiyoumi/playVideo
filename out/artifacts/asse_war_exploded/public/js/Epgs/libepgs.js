/*
*   总 SDK
*
*
*/


function epgs (spec){
    this.epgMedia = epgMedia.init(spec.host,spec.epgId);
    this.epgAd = epgAd.init(spec.host,spec.epgId);
    this.epgArea = epgArea.init(spec.host);
    this.epgCategory = epgCategory.init(spec.host, spec.epgId);
    this.epgChannel = epgChannel.init(spec.host);
    this.epgColumn = epgColumn.init(spec.host, spec.epgId);
    this.epgLanguage = epgLanguage.init(spec.host);
    this.epgProvider = epgProvider.init(spec.host);
    this.epgRcmb = epgRcmb.init(spec.host, spec.epgId);
    this.epgSync = epgSync.init(spec.host, spec.epgId);
}

epgs.init = function (host, epgId) {
    return new epgs({
        epgId: epgId,
        host: host
    });
};

//----------------------------------- media 请求部分
function epgMedia (spec) {
    this.id = spec.epgId;
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/' + spec.epgId + '/media/'
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

epgMedia.init = function (host, epgId) {
    return new epgMedia({
        epgId: epgId,
        host: host
    });
};

epgMedia.prototype.get = function (columnid, token, obj, callback) {
    var url = 'get?columnid=' + columnid + '&token=' + token;
    if (obj != null) {
        if (obj.pagesize != null)
            url += ('&pagesize=' + obj.pagesize);
        if (obj.pageindex != null)
            url += ('&pageindex=' + obj.pageindex);
        if (obj.meta != null)
            url += ('&meta=' + obj.meta);
        if (obj.category != null)
            url += ('&category' + obj.category);
        if (obj.area != null)
            url += ('&area' + obj.area);
        if (obj.tag != null)
            url += ('&tag=' + obj.tag);
        if (obj.year != null)
            url += ('&year=' + obj.year);
        if (obj.title != null)
            url += ('&title=' + obj.title);
        if (obj.pinyin != null)
            url += ('&pinyin=' + obj.pinyin);
        if (obj.actor != null)
            url += ('&actor=' + obj.actor);
        if (obj.sort != null)
            url += ('&sort=' + obj.sort);
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
    }
    this.send(url, null,callback);
};

epgMedia.prototype.detail = function (columnid, token, obj, callback){
    var url = 'detail?columnid=' + columnid + '&token=' + token;
    if (obj != null) {
        if (obj.id != null)
            url += ('&id=' + obj.id);
        if (obj.provider != null)
            url += ('&provider=' + obj.provider);
        if (obj.pageindex != null)
            url += ('&pageindex=' + obj.pageindex);
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
        if (obj.pagesize != null)
            url += ('&pagesize=' + obj.pagesize);
    }
    this.send(url, null,callback);
}

epgMedia.prototype.relate = function (columnid, token, obj, callback){
    var url = 'relate?columnid=' + columnid + '&token=' + token;
    if (obj != null) {
        if (obj.id != null)
            url += ('&id=' + obj.id);
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
        if (obj.size != null)
            url += ('&size=' + obj.size);
    }
    this.send(url, null,callback);
}
//---------------------------- END Media

//---------------------------- Ad 请求部分
function epgAd (spec) {
    this.id = spec.epgId;
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/' + spec.epgId + '/ad/'
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

epgAd.init = function (host, epgId) {
    return new epgAd({
        epgId: epgId,
        host: host
    });
};

epgAd.prototype.get = function (columnid, token, obj, callback) {
    var url = 'get?columnid=' + columnid + '&token=' + token;
    if (obj != null) {
        if (obj.meta != null)
            url += ('&meta=' + obj.meta);
        if (obj.title != null)
            url += ('&title=' + obj.title);
        if (obj.type != null)
            url += ('&type=' + obj.type);
    }
    this.send(url, null, callback);
};

epgAd.prototype.map = function (token, callback){
    var url = 'map?token=' + token;
    this.send(url, null,callback);
}
//----------------- END Ad

//----------------- Area 部分
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
//---------------------- END Area

//---------------------- Category 部分
function epgCategory (spec) {
    this.id = spec.epgId;
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/' + spec.epgId + '/category/'
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

epgCategory.init = function (host, epgId) {
    return new epgCategory({
        epgId: epgId,
        host: host
    });
};

epgCategory.prototype.get = function (columnid, token, obj, callback) {
    var url = 'get?columnid=' + columnid + '&token=' + token;
    if (obj != null) {
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
    }
    this.send(url, null,callback);
};
//------------------- END Category

//------------------- Channel 部分
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
//--------------------- END Channel

//--------------------- Column 部分
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
//---------------------- END Column

//---------------------- Language 部分
function epgLanguage (spec) {
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/language'
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

epgLanguage.init = function (host) {
    return new epgLanguage({
        host: host
    });
};

epgLanguage.prototype.get = function (token, callback) {
    var url = '?token=' + token;
    this.send(url, null,callback);
};
//--------------------- END Language

//--------------------- Provider 部分
function epgProvider (spec) {
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/provider/'
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

epgProvider.init = function (host) {
    return new epgProvider({
        host: host
    });
};

epgProvider.prototype.get = function (token, obj, callback) {
    var url = 'get?token=' + token;
    if (obj != null) {
        if (obj.lang != null)
            url += ('&lang=' + obj.lang);
    }
    this.send(url, null,callback);
};
//------------------ END Provider

//----------------- Rcmb 部分
function epgRcmb (spec) {
    this.id = spec.epgId;
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/' + spec.epgId + '/rcmb/'
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

epgRcmb.init = function (host, epgId) {
    return new epgRcmb({
        epgId: epgId,
        host: host
    });
};

epgRcmb.prototype.get = function (columnid, token, obj, callback) {
    var url = 'get?columnid=' + columnid + '&token=' + token;
    if (obj != null) {
        if (obj.meta != null)
            url += ('&meta=' + obj.meta);
        if (obj.title != null)
            url += ('&title=' + obj.title);
        if (obj.type != null)
            url += ('&type=' + obj.type);
    }
    this.send(url, null, callback);
};

epgRcmb.prototype.map = function (token, callback){
    var url = 'map?token=' + token;
    this.send(url, null,callback);
}
//---------------------------- END Rcmb

//---------------------------- Sync 部分
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
//----------------------- END Sync