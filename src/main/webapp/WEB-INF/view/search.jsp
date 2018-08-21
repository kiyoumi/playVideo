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
    <link rel="icon" href="public/images/logo.png" type="image/x-icon"/>
    <link href="public/Icon/iconfont.css" rel="stylesheet">
    <link href="public/css/Common.css?v=${version}" rel="stylesheet">
    <link href="public/css/user-info.css?v=${version}" rel="stylesheet">
</head>
<body>
<!--头部-->
<jsp:include page="head.jsp" flush="true"/>

<!--搜索结果-->
<div class="search-result-wrapper">
    <div class="result-all">
        <!--搜索到多少条数据-->
        <div class="search-tit">
            <div class="border1"></div>
        </div>
        <!--搜索不到数据的时候显示-->
        <div class="nothing">
            <i class="Hui-iconfont Hui-iconfont-bofang"></i>
            <p>Not searching for what you want</p>
        </div>
        <div class="result-media">
        </div>
    </div>
</div>

<!--页脚-->
<jsp:include page="footer.jsp" flush="true"/>

<script type="text/javascript" src="public/js/jquery.js"></script>
<script type="text/javascript" src="public/js/qrcode.min.js"></script>
<script type="text/javascript" src="public/js/config.js?v=${version}"></script>
<script type="text/javascript" src="public/js/main-mini.js?v=${version}"></script>
<script type="text/javascript" src="public/js/main.js?v=${version}"></script>
<script type="text/javascript" src="public/js/Epgs/libcolumn.js"></script>
<script type="text/javascript" src="public/js/Epgs/libmedia.js"></script>
<script type="text/javascript">
    var lan="en";
    var index=0,pagecount="";
    if(localStorage.getItem("lang")){
        lan=localStorage.getItem("lang");
        if(lan=="zh"){
            $(".zh").addClass("active").siblings().removeClass("active");
            CH();
            $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
            $(".site-container .user-box").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
        }else {
            EN();
        }
    }else {
        EN();
    }
    $(function () {
        getInfo();
        getMedia();
        getColumns();

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
        if(getParameterByName("wd")){
            $("#search").val(getParameterByName("wd"));
        }

        $(".language a").bind("click",function () {
            $(".result-media").html("");
            index=0;
            lan=$(this).attr("lang");
            if(lan=="zh"){
                CH();
                $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
            }else{
                EN();
                $("footer ._footer").eq(0).removeClass("displayNone").siblings().addClass("displayNone");
            }
            $(this).addClass("active").siblings().removeClass("active");
            localStorage.setItem("lang",lan);
            getMedia();
            getInfo();
        })


        window.onscroll=function(){
            scrollauto();
        }
        function scrollauto(){
            var wH=$(window).scrollTop();
            var mH=$(".result-all").height();
            if(wH> mH-650){
                if(index<pagecount){
                    index++;
                    getMedia();
                }
            }
        }
    });

    function getMedia() {
        if(localStorage.getItem("time")){
            localStorage.removeItem("time");
        }
        if(lan=="zh") {
            document.title="搜库";
        }else {
            document.title="Search";
        }
        var context = getParameterByName('wd');
        var media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg);
        media.get('', 'guoziyun',{title:context,lang:lan,pagesize:10,pageindex:index}, function (status, responseText){
            $('#searchList').html('');
            var epgId=ServerConfig.epg;
            if((responseText==null)||(responseText==undefined)||(responseText=="")){
                $('.nothing').css('display','block');
                if(lan=="zh"){
                    $('.nothing p').html('未搜索到您想要的内容');
                }else{
                    $('.nothing p').html('Not searching for what you want');
                }
            }else{
                var media = JSON.parse(responseText);
                pagecount=media.pagecount;
                if(lan=="zh"){
                    $('.search-tit .border1').html('<p>共为你搜索到<span totalcount="'+media.totalcount+'">'+media.totalcount+'</span>条结果</p>');
                }else{
                    $('.search-tit .border1').html('<p>A total of <span totalcount="'+media.totalcount+'">'+media.totalcount+'</span> search results for you</p>');
                }
                if(media.totalcount==0){
                    if(lan=="zh"){
                        $('.nothing p').html('未搜索到您想要的内容');
                    }else{
                        $('.nothing p').html('Not searching for what you want');
                    }
                    $(".result-media").html("");
                    $('.nothing').css('display','block');
                }
                if(media.list.length>0) {
                    $('.nothing').css('display', 'none');
                    var html = '';
                    for (var j = 0; j < media.list.length; j++) {
                        var sco = media.list[j].score / 10;
                        sco = sco.toFixed(1);
                        var des = '';
                        if (media.list[j].description) {
                            des = media.list[j].description;
                        }
                        sco.split('.');
                        html += '<div class="media-info" mediaId="' + media.list[j].id + '" columnid="' + media.list[j].columnId + '"><div class="media-img"><img src="' + media.list[j].thumbnail + '" title="' + media.list[j].title + '"/>';
                        if (lan == "zh") {
                            html += '</div><div class="tele-info-right"><div class="add-collect"><a class="like" mediaId="' + media.list[j].id + '" ' +
                                'columnid="' + media.list[j].columnId + '" imgUrl="' + media.list[j].thumbnail + '"title="' + media.list[j].title + '" ' +
                                'meta="' + media.list[j].meta + '"><i class="Hui-iconfont Hui-iconfont-like"></i>加入收藏</a>';
                            html += '</div><div class="score-box">评分：<span><span class="score-l">' + parseInt(sco) + '</span><span class="score-s">.' + sco[sco.length - 1] + '</span></span>';
                            html += '</div><div class="tele-name-score"><span class="name">' + media.list[j].title + '</span>';
                            html += '</div><ul class="media-info-list"><li><div class="media-area">地区：' + media.list[j].area + ' </div></li>';
                            html += '</ul><div class="info">简介：<span>' + des + '</span>';
                            html += '</div><div class="btn-box"><a href="play?columnid=' + media.list[j].columnId + '&id=' + media.list[j].id + '&title=' + media.list[j].title + '" class="bofang">立即播放</a>' +
                                '<a href="detail?columnid=' + media.list[j].columnId + '&id=' + media.list[j].id + '" class="see-details">查看详情</a>';
                        } else {
                            html += '</div><div class="tele-info-right"><div class="add-collect"><a class="like" mediaId="' + media.list[j].id + '" ' +
                                'columnid="' + media.list[j].columnId + '" imgUrl="' + media.list[j].thumbnail + '"title="' + media.list[j].title + '" ' +
                                'meta="' + media.list[j].meta + '"><i class="Hui-iconfont Hui-iconfont-like"></i>Add to collection</a>';
                            html += '</div><div class="score-box">Score：<span><span class="score-l">' + parseInt(sco) + '</span><span class="score-s">.' + sco[sco.length - 1] + '</span></span>';
                            html += '</div><div class="tele-name-score"><span class="name">' + media.list[j].title + '</span>';
                            html += '</div><ul class="media-info-list"><li><div class="media-area">Area：' + media.list[j].area + ' </div></li>';
                            html += '</ul><div class="info">Description：<span>' + des + '</span>';
                            html += '</div><div class="btn-box"><a href="play?columnid=' + media.list[j].columnId + '&id=' + media.list[j].id + '&title=' + media.list[j].title + '" target="_blank" class="bofang">Play immediately</a>' +
                                '<a target="_blank" href="detail?columnid=' + media.list[j].columnId + '&id=' + media.list[j].id + '" class="see-details">View Detail</a>';
                        }
                        html += '</div></div></div>';
                    }
                    $('.result-media').append(html);
                    add_collect();
                    if(getCookie("signUin")){
                        getCollectInfo(epgId);
                    }
                }
            }
        });
        $(".info span").each(function () {
            var str = $(this).text();
            var s = str;
            if(str.length>200){
                s = str.substring(0,200)+"......";
                $(this).text(s);
            }
        });


        //演员
        $('.actor').each(function () {
            var str = $(this).text();
            if(str.length > 65){
                str = str.substring(0,65)+'...';
            }
            $(this).text(str);
        });

    }
    function add_collect(){
        var epgId=ServerConfig.epg;
        $('.add-collect a.like').unbind("click").bind("click",function () {
            var mediaId = $(this).attr('mediaId');
            var columnId = $(this).attr('columnId');
            var meta = $(this).attr('meta');
            var imageSrc = $(this).attr('imgUrl');
            var title = $(this).attr('title');
            if(getCookie("signUin")){
                var obj='',result='',media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg),enFavorite=[],zhFavorite=[];
                if($(this).attr('class')=='like'){
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
                            if (enFavorite[k].epgId == epgId && enFavorite[k].columnId == columnId && enFavorite[k].mediaId == mediaId && enFavorite[k].userId ==localStorage.getItem("uin")) {
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
    }

    function getCollectInfo(epgId){
        for(var m=0;m<$(".media-info").length;m++){
            if(lan=="zh"){
                if(localStorage.getItem("zhFavorite")){
                    var zhFavorite=JSON.parse(localStorage.getItem("zhFavorite"));
                    for(var i=0;i<zhFavorite.length;i++) {
                        if ( epgId==zhFavorite[i].epgId  && $(".media-info").eq(m).attr("columnid") ==zhFavorite[i].columnId  && $(".media-info").eq(m).attr("mediaId") ==zhFavorite[i].mediaId && localStorage.getItem("uin")==zhFavorite[i].user ) {
                            $(".media-info").eq(m).find(".add-collect a").addClass('liked').html('<i class="Hui-iconfont">&#xe648;</i>已收藏');
                        }
                    }
                }
            }else{
                if(localStorage.getItem("enFavorite")){
                    var enFavorite=JSON.parse(localStorage.getItem("enFavorite"));
                    for(var k=0;k<enFavorite.length;k++) {
                        if ( epgId==enFavorite[k].epgId  &&  $(".media-info").eq(m).attr("columnid")==enFavorite[k].columnId  && $(".media-info").eq(m).attr("mediaId")== enFavorite[k].mediaId && localStorage.getItem("uin")==enFavorite[k].userId) {
                            $(".media-info").eq(m).find(".add-collect a").addClass('liked').html('<i class="Hui-iconfont">&#xe648;</i>Have been collected');
                        }
                    }
                }
            }
        }
    }
</script>
</body>
</html>