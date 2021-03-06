function epgProduct (spec) {
    this.id = spec.epgId;
    this.host = spec.host;
    this.url = 'http://' + spec.host + '/epgs/' + spec.epgId + '/product/'
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

epgProduct.init = function (host, epgId) {
    return new epgProduct({
        epgId: epgId,
        host: host
    });
};

epgProduct.prototype.content = function (token, obj, callback) {
    var url = 'content?token=' + token;
    if (obj != null) {
        if (obj.pagesize != null)
            url += ('&pagesize=' + obj.pagesize);
        if (obj.pageindex != null)
            url += ('&pageindex=' + obj.pageindex);
        if (obj.meta != null)
            url += ('&meta=' + obj.meta);
        if (obj.category != null)
            url += ('&category=' + obj.category);
        if (obj.area != null)
            url += ('&area=' + obj.area);
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

