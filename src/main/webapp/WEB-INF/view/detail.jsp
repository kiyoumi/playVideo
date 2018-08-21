<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/WEB-INF/view/lib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title></title>
    <link href="public/Icon/iconfont.css" rel="stylesheet">
    <link rel="icon" href="public/images/logo.png" type="image/x-icon"/>
    <link href="public/css/Common.css?v=${version}" rel="stylesheet">
    <link rel="stylesheet" href="public/css/details.css?v=${version}"/>
</head>
<body>

<!--头部-->
<jsp:include page="head.jsp" flush="true"/>
<section id="media">
    <div class="tele-details-box">
        <div class="tele-content">
            <div class="tele-name" style="margin-top: 30px;">
                <div class="biao"></div>
                <div class="border1"></div>
            </div>
            <div class="tele-details">
                <div class="tele-img">
                </div>
                <div class="content-list">
                    <div class="grade">
                        Score：
                        <span>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="episode-list tele" style="display: none;">
            <div class="episode-tit">
                <div class="biao"></div>
                <p>Episodes list</p>
                <div class="border1"></div>
            </div>

            <div class="select-s">
                <ul>
                </ul>
            </div>
        </div>
        <div class="episode-list variety" style="display: none;">
            <div class="episode-tit">
                <div class="biao"></div>
                <p>Episodes list</p>
                <div class="border1"></div>
            </div>

            <div class="variety-list">
                <ul>
                </ul>
            </div>
        </div>
        <div class="more-recommend">
            <div class="recommend-tit">
                <div class="biao"></div>
                <p>Related recommendations</p>
            </div>
            <div class="border1"></div>
            <div class="recommend-tele">
                <ul>
                </ul>
            </div>
        </div>
    </div>
    <div class="tele-details-box displayNone">
        <div class="tele-content">
            <div class="tele-name" style="margin-top: 30px;">
                <div class="biao"></div>
                <div class="border1"></div>
            </div>
            <div class="tele-details">
                <div class="tele-img">
                </div>
                <div class="content-list">
                    <div class="grade">
                        评分：
                        <span>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="episode-list tele" style="display: none;">
            <div class="episode-tit">
                <div class="biao"></div>
                <p>剧集列表</p>
                <div class="border1"></div>
            </div>

            <div class="select-s">
                <ul>
                </ul>
            </div>
        </div>
        <div class="episode-list variety" style="display: none;">
            <div class="episode-tit">
                <div class="biao"></div>
                <p>剧集列表</p>
                <div class="border1"></div>
            </div>

            <div class="variety-list">
                <ul>
                </ul>
            </div>
        </div>
        <div class="more-recommend">
            <div class="recommend-tit">
                <div class="biao"></div>
                <p>相关推荐</p>
            </div>
            <div class="border1"></div>
            <div class="recommend-tele">
                <ul>
                </ul>
            </div>
        </div>
    </div>
</section>

<!--页脚-->
<jsp:include page="footer.jsp" flush="true"/>
<script type="text/javascript" src="public/js/jquery.js"></script>
<script type="text/javascript" src="public/js/qrcode.min.js"></script>
<script type="text/javascript" src="public/js/config.js?v=${version}"></script>
<script type="text/javascript" src="public/js/main-mini.js?v=${version}"></script>
<script type="text/javascript" src="public/js/iscroll.js"></script>
<script type="text/javascript" src="public/js/jquery.cookie.js"></script>
<script type="text/javascript" src="public/js/ckplayer/ckplayer.js"></script>
<script type="text/javascript" src="public/js/main.js?v=${version}"></script>
<script type="text/javascript" src="public/js/OIS/libois.js"></script>
<script type="text/javascript" src="public/js/Epgs/libcolumn.js"></script>
<script type="text/javascript" src="public/js/Epgs/libmedia.js"></script>
<script type="text/javascript">
    var lan="en";
    if(localStorage.getItem("lang")){
        lan=localStorage.getItem("lang");
        if(lan=="zh"){
            $(".zh").addClass("active").siblings().removeClass("active");
            CH();
            $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
            $(".tele-details-box").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
        }else{
            EN();
        }
    }else{
        EN();
    }

    $(function () {
        getInfo();
        getColumns();
        var _columnid = getParameterByName('columnid');
        //从url获取栏目id的名字
        var _mediaid = getParameterByName('id');
        $('#media').attr('mediaId',_mediaid );
        $('#media').attr('columnId',_columnid );
        mediaDR();

        $(".select-l li").click(function () {
           $(this).addClass("active").siblings("li").removeClass("active");
            var _index = $(this).index();
            $(".select-s ul").eq(_index).css("display","block").siblings("ul").css("display","none");
        });

    });

    //演员名字过长就用省略号显示
    var v = $(".actor a").text();
    if(v.length>30){
        v = v.substring(0,30)+'...';
        $('.actor a').text(v);
    }
    //点击搜索
    $('#sub_search').click(function() {
        var title = $('#search').val();
        if (title != '' && title != null) {
            window.location.href='search?wd=' + title;
        }else{
            $("#search").focus();
        }
    });


    document.onkeydown = function(event) {
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if (e && e.keyCode == 13) {
            var title = $('#search').val();
            if (title != '') {
                window.location.href='search?wd=' + title;
            }
            if (title == '') {
                return false;
            }
        }
    }


    $('.variety-list a').click(function () {
        var id = $('#media').attr('mediaId');
        var columnid = $('#media').attr('columnId');
        var title = $('#media').attr('title');
        var imgUrl = $('#media').attr('imgUrl');
        var epis = $(this).attr('epis');
        var obj = {
            time:'0',
            title:title,
            id:id,
            columnid:columnid,
            epis:epis,
            imgUrl:imgUrl
        };
        if(localStorage.getItem('playRecord')==null){
            var playRecord = new Array();
            playRecord.push(obj);
            localStorage.setItem('playRecord',JSON.stringify(playRecord));
        }else{
            var playRecord = JSON.parse(localStorage.getItem("playRecord"));
            for(var i = 0;i < playRecord.length; i++){
                if(playRecord[i].id == id){
                    playRecord.splice(i,1);
                    playRecord.unshift(obj);
                    localStorage.setItem('playRecord',JSON.stringify(playRecord));
                    return;
                }
            }
            playRecord.unshift(obj);
            localStorage.setItem('playRecord',JSON.stringify(playRecord));
        }
    })

    var meta = $('.tele-details-box').attr('meta');
    if(meta==2){
        $('.tele').css('display','block');
    }if(meta==4){
        $('.variety').css('display','block');
    }

    function mediaDR() {
        var media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg);
        media.detail($('#media').attr('columnId'), 'guoziyun', { id:$('#media').attr('mediaId'),lang:lan}, function (status, responseText){
            var result=JSON.parse(responseText);
            document.title=result.title;
            $('#media').attr('meta',result.meta);
            $('#media').attr('imgUrl',result.thumbnail);
            $('#media').attr('title',result.title);
            $('.tele-details-box').attr('meta',result.meta);
            $('.tele-content .tele-name').html('<p style="height: 17px;width: 100%;overflow: hidden;">'+result.title+'<span class="year">'+result.year+'</span></p>');
            $('.tele-content .tele-img').html('<img src="'+result.thumbnail+'" title="'+result.title+'"/>');
            var score = result.score/10;
            s = parseInt(score/2);
            for(var i = 0; i< s; i++){
                $('.grade span').html('<i class="Hui-iconfont Hui-iconfont-star"></i>');
            }
            if(parseInt(score%2)==1){
                $('.grade span').html('<i class="Hui-iconfont Hui-iconfont-star-halfempty"></i>');
                for(var j = 0;j < 5-s-1; j ++){
                    $('.grade span').html('<i class="Hui-iconfont Hui-iconfont-star-o"></i>');
                }
            }
            if(parseInt(score%2)==0) {
                for (var j = 0; j < 5 - s; j++) {
                    $('.grade span').html('<i class="Hui-iconfont Hui-iconfont-star-o"></i>');
                }
            }
            var sco = result.score/10;
            sco = sco.toFixed(1);
            sco.split('.');
            $('.grade span').html('<span class="score"> <em class="score-l">'+parseInt(sco)+'<em class="score-s">.'+ sco[sco.length - 1] +'</em></em> </span>');
            if(lan=="zh"){
                $('.content-list').html('<div class="show">Release ：<span>'+result.year+'年</span> </div> <div class="mt-10"> <div class="area f-50">地区： ' +
                    '<a href="">'+result.area+'</a> </div></div> <div class="play mt-10"><a href="play?id='+result.id+'&columnid='+result.columnId+'&title='+result.title+'">立即播放<i class="Hui-iconfont Hui-iconfont-bofang"></i></a> <a class="collect"' +
                    'mediaId="'+result.id+'" columnid="'+result.columnId+'" imgUrl="'+result.image+'" title="'+result.title +'" meta="'+result.meta +'"><i ' +
                    'class="Hui-iconfont Hui-iconfont-like"></i>加入收藏</a> </div> <div class="synopsis mt-10">剧情简介： <br/> <span>'+result.description +'</span></div>');
            }else{
                $('.content-list').html('<div class="show">Release Data：<span>'+result.year+' year</span> </div> <div class="mt-10"> <div class="area f-50">Area： ' +
                    '<a href="">'+result.area+'</a> </div></div> <div class="play mt-10"><a href="play?id='+result.id+'&columnid='+result.columnId+'&title='+result.title+'">Play immediately<i class="Hui-iconfont Hui-iconfont-bofang"></i></a> <a class="collect"' +
                    'mediaId="'+result.id+'" columnid="'+result.columnId+'" imgUrl="'+result.image+'" title="'+result.title +'" meta="'+result.meta +'"><i ' +
                    'class="Hui-iconfont Hui-iconfont-like"></i>Add to Collection</a> </div> <div class="synopsis mt-10">Synopsis： <br/> <span>'+result.description +'</span></div>');
            }
            //获取媒资的集数
            if($('#media').attr('meta')==2|| $('#media').attr('meta')==6 || $('#media').attr('meta')==3){
                var html="";
                $('.episode-list.tele').css('display','block');
                for(var i = 0; i < result.urls.length;i++){
                    html+='<li><a href="play?id='+result.id+'&columnid='+result.columnId+'&title='+result.title+'&d_num='+result.urls[i].serial+'" epis="'+i+'">'+result.urls[i].serial+'</a></li>';
                }
                $('.select-s ul').html(html);
            }
            if($('#media').attr('meta')==4){
                var html='';
                $('.episode-list.variety').css('display','block');
                for(var i = 0; i < result.urls.length;i++){
                    html+='<li><a href="play?id='+result.id+'&columnid='+result.columnId+'&title='+result.title+'&d_num='+result.urls[i].serial+'" epis="'+i+'">'+result.urls[i].serial+'</a></li>';
                }
                $('.variety-list ul').html(html);
            }
            var epgId=ServerConfig.epg;
            var mediaId = $('#media').attr('mediaid');
            var columnId = $('#media').attr('columnid');
            $('.play.mt-10 a.collect').unbind("click").bind("click",function () {
                var meta = $('#media').attr('meta');
                var imageSrc = $('#media').attr('imgUrl');
                var title = $('#media').attr('title');
                var obj='',result='',media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg),enFavorite=[],zhFavorite=[];
                if(getCookie("signUin")){
                    if($(this).attr('class')=='collect'){
                        if(lan=="zh"){
                            $(this).addClass('liked').html('<i class="Hui-iconfont">&#xe648;</i>已收藏');
                            if(localStorage.getItem("zhFavorite")){
                                var zhF=JSON.parse(localStorage.getItem("zhFavorite"));
                                if(zhF.length>0){
                                    for(var r=0;r<zhF.length;r++) {
                                        zhFavorite.push(JSON.stringify(zhF[r]));
                                    }
                                }
                            }
                            obj = { columnId:columnId,meta:meta,epgId:epgId,mediaId:mediaId,title:title,image:imageSrc,userId:localStorage.getItem("uin")};
                            zhFavorite.push(JSON.stringify(obj));
                            localStorage.setItem("zhFavorite","["+zhFavorite+"]");
                            media.detail(columnId, 'guoziyun', { id:mediaId,lang:"en" }, function (status, responseText){
                                if(localStorage.getItem("enFavorite")){
                                    var enF=JSON.parse(localStorage.getItem("enFavorite"));
                                    if(enF.length>0){
                                        for(var j=0;j<enF.length;j++) {
                                            enFavorite.push(JSON.stringify(enF[j]));
                                        }
                                    }
                                }
                                result=JSON.parse(responseText);
                                obj = { columnId:columnId,meta:meta,epgId:epgId,mediaId:mediaId,title:result.title,image:result.image,userId:localStorage.getItem("uin")};
                                enFavorite.push(JSON.stringify(obj));
                                localStorage.setItem("enFavorite","["+enFavorite+"]");
                            });
                        }else{
                            $(this).addClass('liked').html('<i class="Hui-iconfont">&#xe648;</i>Have been collected');
                            if(localStorage.getItem("enFavorite")){
                                var enF=JSON.parse(localStorage.getItem("enFavorite"));
                                if(enF.length>0){
                                    for(var j=0;j<enF.length;j++) {
                                        enFavorite.push(JSON.stringify(enF[j]));
                                    }
                                }
                            }
                            obj = { columnId:columnId,meta:meta,epgId:epgId,mediaId:mediaId,title:title,image:imageSrc,userId:localStorage.getItem("uin")};
                            enFavorite.push(JSON.stringify(obj));
                            localStorage.setItem("enFavorite","["+enFavorite+"]");
                            media.detail(columnId, 'guoziyun', { id:mediaId,lang:"zh" }, function (status, responseText){
                                if(localStorage.getItem("zhFavorite")){
                                    var zhF=JSON.parse(localStorage.getItem("zhFavorite"));
                                    if(zhF.length>0){
                                        for(var r=0;r<zhF.length;r++) {
                                            zhFavorite.push(JSON.stringify(zhF[r]));
                                        }
                                    }
                                }
                                result=JSON.parse(responseText);
                                obj = { columnId:columnId,meta:meta,epgId:epgId,mediaId:mediaId,title:result.title,image:result.image,userId:localStorage.getItem("uin")};
                                zhFavorite.push(JSON.stringify(obj));
                                localStorage.setItem("zhFavorite","["+zhFavorite+"]");
                            });
                        }
                    }else{
                        if(lan=="zh"){
                            $(this).removeClass('liked').html('<i class="Hui-iconfont">&#xe649;</i>加入收藏');
                        }else{
                            $(this).removeClass('liked').html('<i class="Hui-iconfont">&#xe649;</i>Add to Collection');
                        }
                        if(localStorage.getItem("enFavorite")){
                            enFavorite=JSON.parse(localStorage.getItem("enFavorite"));
                            zhFavorite=JSON.parse(localStorage.getItem("zhFavorite"));
                            for(var k=0;k<enFavorite.length;k++) {
                                if (enFavorite[k].epgId == epgId && enFavorite[k].columnId == columnId && enFavorite[k].mediaId == mediaId && enFavorite[k].userId==localStorage.getItem("uin")) {
                                    enFavorite.splice(k,1);
                                    zhFavorite.splice(k,1);
                                    if(enFavorite.length==0){
                                        localStorage.removeItem("enFavorite");
                                        localStorage.removeItem("zhFavorite");
                                    }else{
                                        localStorage.setItem("zhFavorite",JSON.stringify(zhFavorite));
                                        localStorage.setItem("enFavorite",JSON.stringify(enFavorite));
                                    }
                                }
                            }
                        }
                    }

                }else{
                    if(lan=="zh"){
                        alert("登录进行操作!");
                    }else{
                        alert("Login to operate");
                    }
                }
            })
            if(getCookie("signUin")){
                getCollectInfo(epgId,columnId,mediaId);
            }
        });
        //获取相关媒资
        media.relate($('#media').attr('columnId'), 'guoziyun', {id: $('#media').attr('mediaId'),lang:lan,size:12}, function (status, responseText){
            var result=JSON.parse(responseText);
            var hml="";
            if(result.length>0){
                for(var i=0;i<result.length;i++){
                    hml+='<li> <a href="play?id='+result[i].id+'&columnid='+result[i].columnId +'&title='+result[i].title+'">'+
                        '<div class="tele-img"> <img src="'+result[i].image+'" titie="'+result[i].title+'"/> </div> <div class="tele-name">' +
                        '<p>'+result[i].title+'</p> </div> </a> </li>';
                }
                $('.recommend-tele ul').html(hml);
            }
        });
    }

    function getCollectInfo( epgId, columnId, mediaId){
        if(lan=="zh"){
            if(localStorage.getItem("zhFavorite")){
                var zhFavorite=JSON.parse(localStorage.getItem("zhFavorite"));
                for(var i=0;i<zhFavorite.length;i++) {
                    if ( epgId==zhFavorite[i].epgId  && columnId ==zhFavorite[i].columnId  && mediaId ==zhFavorite[i].mediaId && localStorage.getItem("uin")==zhFavorite[i].userId ) {
                        $('.play.mt-10 a.collect').addClass('liked').html('<i class="Hui-iconfont">&#xe648;</i>已收藏');
                    }
                }
            }
        }else{
            if(localStorage.getItem("enFavorite")){
                var enFavorite=JSON.parse(localStorage.getItem("enFavorite"));
                for(var k=0;k<enFavorite.length;k++) {
                    if ( epgId==enFavorite[k].epgId  &&  columnId==enFavorite[k].columnId  && mediaId== enFavorite[k].mediaId && localStorage.getItem("uin")==enFavorite[k].userId) {
                        $('.play.mt-10 a.collect').addClass('liked').html('<i class="Hui-iconfont">&#xe648;</i>Have been collected');
                    }
                }
            }
        }
    }

    $(".language a").bind("click",function () {
        lan=$(this).attr("lang");
        if(lan=="zh"){
            CH();
            $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
            $(".tele-details-box").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
        }else{
            EN();
            $("footer ._footer").eq(0).removeClass("displayNone").siblings().addClass("displayNone");
            $(".tele-details-box").eq(0).removeClass("displayNone").siblings().addClass("displayNone");
        }
        $(this).addClass("active").siblings().removeClass("active");
        localStorage.setItem("lang",lan);
        mediaDR();
        getInfo();
    })
</script>
</body>
</html>