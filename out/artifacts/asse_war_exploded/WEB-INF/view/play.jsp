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
    <link rel="icon" href="public/images/logo.png" type="image/x-icon"/>
    <link href="public/Icon/iconfont.css" rel="stylesheet">
    <link href="public/css/Common.css?v=${version}" rel="stylesheet">
    <link rel="stylesheet" href="public/css/details.css?v=${version}"/>
    <link href="public/css/video-js.css" rel="stylesheet">
    <style type="text/css">
        .site-container .video-wall .player .movie-info-box .on-now {
            padding: 10px 10px 0 10px;
            background: none;
        }
        .site-container .video-wall .player .channel-list {
            height: 450px;
        }
        .site-container .video-wall .player .variety-info-box .variety-details .details .variety-name p {
            color: white;
        }
        .site-container .video-wall .player .channel-name {
            color:white;
            font-size: 22px;
            padding:0 0 20px 0;
            font-weight: normal;
        }
        .site-container .video-wall .player .movie-info-box .movie-details .details,.site-container .video-wall .player .movie-info-box .movie-details .details .movie-name p {
            color: white;
        }
        .commentYes {
            width: auto;
            padding:0 8px;
        }
        .wrapper .wrapper-main .wrapper-left .more-recommend .recommend-tit {
            color: #000;
        }
        .wrapper .wrapper-main .wrapper-left .review-box {
            color: #000;
        }
        .site-container .video-wall .player .buy-box .membership-button a {
            padding: 10px 20px;
        }
        .site-container .video-wall .player .movie-info-box .on-now .on-now-name {
            color: white;
        }
        .site-container .video-wall .player .movie-info-box {
            max-height: 360px;
        }
        .wrapper .wrapper-main .wrapper-left .review-box .comment-box .publish a {
            padding: 2px 8px;
        }
        .tips_box{
            display: none;
            position: absolute;
            width: 300px;
            height: 150px;
            background: #BB242B;
            top:50%;
            left:50%;
            margin-left: -150px;
            margin-top: -75px;
        }
        .tips_box .close{
            position: absolute;
            display: inline-block;
            right: -10px;
            top:-10px;
            font-size: 22px;
            color:#fff;
            background: #BB242B;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            text-align: center;
            line-height: 30px;
            cursor: pointer;
        }
        .tips_main{
            text-align: center;
            margin-top: 50px;
        }
        .tips_main span{
            color:#f2f2f2;
            font-size: 14px;
        }
        .tips_main a{
            font-size: 16px;
            color:#fff;
        }
        .path{
            color: #cacaca;
            font-size: 16px;
            font-weight: normal;
            padding: 10px 0;
        }
        .path a{
            text-decoration: none;
            color: #cacaca;
        }
    </style>
</head>
<body>
<!--头部-->
<div id="hiddenUrl"></div>
<jsp:include page="head.jsp" flush="true"/>

<!--播放器区域-->
<div class="site-container" id="media">
    <!--播放器区域 开始-->
    <div class="video-wall">
        <div class="player">
            <h2 class="path"><a class="homePath">Home</a> > <a class="gradeName"></a> > <a class="subject"></a> > <a class="unit"></a></h2>
            <h2 class="channel-name"><span></span></h2>
            <div class="mod-player">
            </div>
            <!--播放器结束-->
        </div>
    </div>
    <!--播放器区域 结束-->
</div>
<!--猜你喜欢，影评-->
<div class="wrapper">
    <div class="wrapper-main">
        <div class="wrapper-left">
            <div class="tele-info">
            </div>
            <div class="more-recommend">
                <div class="recommend-tit">
                    <div class="biao"></div>
                    <p>Guess you like</p>
                </div>
                <div class="border1"></div>
                <div class="recommend-movie">
                    <ul>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!--页脚-->
<jsp:include page="footer.jsp" flush="true"/>

<script type="text/javascript" src="public/js/jquery.js"></script>
<script type="text/javascript" src="public/js/qrcode.min.js"></script>
<script type="text/javascript" src="public/js/config.js?v=${version}"></script>
<script type="text/javascript" src="public/js/sha256.js"></script>
<script type="text/javascript" src="public/js/jquery.nicescroll.js"></script>
<script type="text/javascript" src="public/js/main-mini.js?v=${version}"></script>
<script type="text/javascript" src="public/js/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript" src="public/js/json2.min.js"></script>
<script type="text/javascript" src="public/js/main.js?v=${version}"></script>
<script type="text/javascript" src="public/js/jquery.cookie.js"></script>
<script type="text/javascript" src="public/js/Epgs/libcolumn.js"></script>
<script type="text/javascript" src="public/js/Epgs/libmedia.js"></script>
<script type="text/javascript">
    //播放集数
    var lan="en";
    if(localStorage.getItem("lang")){
        lan=localStorage.getItem("lang");
        if(lan=="zh"){
            $(".zh").addClass("active").siblings().removeClass("active");
            CH();
            $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
            $(".wrapper-main .recommend-tit p").html("您可能喜欢");
        }else {
            EN();
        }
    }else {
        EN();
    }
    var num=0,episode='';
    function autoScrollResize() {
        var content_h = document.body.clientHeight; // 内容高度
        var content_w = document.body.clientWidth; // 内容宽度
        var broswer_h = document.documentElement.clientHeight; // 浏览器窗口的可视高度
        var broswer_w = document.documentElement.clientWidth; // 浏览器窗口的可视宽度
        if(content_h < broswer_h && content_w < broswer_w) {
            document.getElementsByTagName('body')[0].style.overflow = 'hidden';
            document.getElementsByTagName('html')[0].style.overflow = 'hidden'; // 在DTD标准下，为html元素设置overflow:hidden才能去掉滚动条
        } else {
            document.getElementsByTagName('html')[0].style.overflow = 'auto';
        }
    }
    window.onload = function() {
        if(window.ActiveXObject) { // 针对IE
            autoScrollResize();
            window.attachEvent("onresize", autoScrollResize); // 使用ie的resize时事件监听
        }
    }

    $(function() {
        getInfo();
        getColumns();
        var _columnid=getParameterByName('columnid');
        var _title=getParameterByName('title');
        var _id=getParameterByName('id');
        $(".gradeName").html(getParameterByName("name"));
        $(".gradeName").attr("href","list?columnid="+_columnid.substring(0,3)+"&name="+getParameterByName("name"));
        $(".subject").attr("href","list?columnid="+_columnid.substring(0,3)+"&name="+getParameterByName("name")+"&subject="+_columnid.substring(0,5));
        $(".unit").attr("href","list?columnid="+_columnid.substring(0,3)+"&name="+getParameterByName("name")+"&subject="+_columnid.substring(0,5)+"&unit="+_columnid);
        $(".homePath").attr("href","");
        $('#media').attr({'mediaId':_id,'columnId':_columnid});
        detail();

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
    });
    function add_collect(){
        var epgId=ServerConfig.epg;
        var userId='';
        var mediaId = $('#media').attr('mediaId');
        var columnId = $('#media').attr('columnId');
        var meta = $('#media').attr('meta');
        var imageSrc = $('#media').attr('imgUrl');
        var title = $('#media').attr('title');
        $('.add-collect a').unbind("click").bind("click",function () {
            var obj='',result='',media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg),enFavorite=[],zhFavorite=[];
            if(getCookie("signUin")){
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
        getCollectInfo(epgId,columnId,mediaId);
    }

    //mop url
    function change(){
        getHistory();
        //滚动条样式
        $('.Slider').niceScroll({
            cursorcolor: "#555",//#CC0071 光标颜色
            cursoropacitymax: 1, //改变不透明度非常光标处于活动状态（scrollabar“可见”状态），范围从1到0
            cursorwidth: "5px", //像素光标的宽度
            cursorborder: "0", // 	游标边框css定义
            cursorborderradius: "0px",//以像素为光标边界半径
            autohidemode: false //是否隐藏滚动条
        });

        //控制电影节目信息显示
        $(".Program .btn").click(function() {
            $(".Program p").toggle();
        });

        add_collect();

        var str = $('.actor a').text();
        if(str.length > 15){
            str = str.substring(0,15)+'...';
        }
        $('.actor a').text(str);

        //$(".episode-list ul li").eq(num).find("a").addClass("active").siblings("li").find("a").removeClass("active");

        //显示开通会员
        var price = $('#media').attr('price');
        if(price != 0){
            $('.buy-box').css('display','block');
        }

        //控制播放区域、右边列表展示
        $(".s-div").click(function () {
            $(".channel-list").css('display', 'none');
            $('#ascrail2000 div').css('width', '0px');
            $(".mod-player").animate({width: '1090px'}, 10);
            $(".s-div1").css("display", "block");
            $(this).css("display", "none");
        });
        $(".s-div1").click(function () {
            $(".channel-list").css('display', 'block');
            $('#ascrail2000 div').css('width', '5px');
            $(".mod-player").animate({width: '800px'}, 10);
            $(".s-div").css("display", "block");
            $(this).css("display", "none");
        });


        $(".show-tab a").click(function() {
            $(this).addClass("active").parent("li").siblings("li").find("a").removeClass("active");
            num=$(this).attr("episode");
        });
        $(".central-TV-list li").click(function() {
            $(this).addClass("active").siblings("li").removeClass("active");
            num=$(this).attr("episode");
        });

        //综艺
        $(".variety-list li").click(function () {
            $(this).addClass("active").siblings("li").removeClass("active");
            $('.channel-name span').text($(this).attr('url_title'));
            var index = $(this).attr("episode");
            num=index;
            play(index);
        });
        //电视剧
        $(".episode-list li a").click(function() {
            $(this).addClass("active").parent("li").siblings("li").find("a").removeClass("active");
            $('.channel-name span').text($('.episode-list .active').attr('url_title'));
            var index = $(this).attr("episode");
            num=index;
            play(index);
        });

    }

    //拿观看缓存出来如果有记录就从缓存的第几集开始播放
    function getHistory() {
        var result=[];
        var epgId=ServerConfig.epg;
        var mediaId = $('#media').attr('mediaId');
        var columnId = $('#media').attr('columnId');
        if(getParameterByName('d_num')){
            num=getParameterByName('d_num')-1;
        }
        if(getCookie("signUin")){
            if(localStorage.getItem("enHistory")){
                var enH=JSON.parse(localStorage.getItem("enHistory"));
                for(var o=0;o<enH.length;o++){
                    if(enH[o].userId==localStorage.getItem("uin")){
                        result.push(enH[o]);
                    }
                }
            }
            if(result.length>0){
                for(var i=0;i<result.length;i++){
                    if(result[i].columnId==columnId && result[i].mediaId==mediaId && result[i].epgId==epgId && result[i].userId==localStorage.getItem("uin")){
                        localStorage.setItem("time",result[i].time);
                        localStorage.setItem("seria",result[i].seria);
                        if(getParameterByName('d_num')){
                            num=getParameterByName('d_num')-1;
                        }else{
                            num=result[i].seria;
                        }
                    }
                }
            }
        }
        $('.episode-list a').eq(num).addClass('active').parent("li").siblings("li").find("a").removeClass("active");
        $('.variety-list li').eq(num).addClass('active').siblings("li").removeClass("active");
        $('.episode-list').attr('cur',num);

        PlayUtil.setOIS(sessionStorage.getItem("accesssvr"));
        play(num);
    }

    function detail() {
        $(".mod-player").html("");
        var mediaId = $('#media').attr('mediaId');
        var columnId = $('#media').attr('columnId');
        var result,urlHtml="";
        var media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg);
        media.detail(columnId, 'guoziyun', { id:mediaId,lang:lan }, function (status, responseText){
            result=JSON.parse(responseText);
            var _urls = result.urls;
            if(_urls){
                for(var i=0;i<_urls.length;i++){
                    urlHtml+='<p name="url" final="'+_urls[i].isfinal+'" style="display:none;">'+_urls[i].url+'</p>';
                }
                $("#hiddenUrl").html(urlHtml);
            }
            $('#media').attr({'meta':result.meta,'price':result.price,'imgUrl':result.image});
            var meta=$('#media').attr('meta');
            $(".channel-list,.channel-list-control").remove();
            document.title=result.title;
            $('.channel-name').html(result.title);
            //电影
            if(meta==1){
                $('#price').attr('price',result.price);
                var sco = result.score/10;
                sco = sco.toFixed(1);
                sco.split('.');
                if(lan=="zh"){
                    $('.player').append('<!--播放列表开始--> <div class="channel-list"> ' +
                        '<div class="show-tab"> <ul><li><a class="central-TV-tab active">正在播放</a></li> </ul></div><!--右边电影介绍--> ' +
                        '<div class="movie-info-box Slider"> <div class="movie-details"> <div class="details"> </div> </div> ' +
                        '<div class="on-now"> <div class="movie-img-s"> <img src/> </div> ' +
                        '<div class="on-now-name f"> <p class="title"></p> <p><i class="Hui-iconfont">&#xe6e6;</i>正在播放...</p> </div> </div>' +
                        '<div class="mod-handle"><div class="add-collect mt-5"> <a class="like"><i class="Hui-iconfont">&#xe649;</i>加入收藏</a> </div>&nbsp;<span class="SeparationLine">|</span> &nbsp;' +
                        '<div class="downloadMeta"><a><i class="Hui-iconfont Hui-iconfont-down"></i>下载</a></div></div> </div> </div> ' +
                        '<div class="channel-list-control"> <div class="s-div"> <span class="Hui-iconfont">&#xe63d;</span> </div>' +
                        ' <div class="s-div1" style="display: none;"> <span class="Hui-iconfont">&#xe67d;</span> </div> </div> <!--播放列表 结束-->')
                    $('.details').append('<div class="movie-name"><p>'+result.title+'<span class="score"><span class="score-l">'+parseInt(sco)+'</span>' +
                        '<span class="score-s">. '+sco[sco.length - 1] +'</span>分</span> </p> </div> ' +
                        '<div class="screened mt-5"> 上映时间：'+ result.year+' </div>  <div class="actor mt-5"> 主演：<ul> <li><a>'+result.actor+'</a></li> </ul> </div> ' +
                        '<div class="Program mt-5"> <div class="btn">片源信息<i class="Hui-iconfont">&#xe6d5;</i></div> <p>'+result.description+'</p> </div> ' +
                        '<div class="add-collect mt-5"> <a class="like"><i class="Hui-iconfont">&#xe649;</i>加入收藏</a> </div>');
                }else{
                    $('.player').append('<!--播放列表开始--> <div class="channel-list"> ' +
                        '<div class="show-tab"> <ul><li><a class="central-TV-tab active">Playing</a></li> </ul></div><!--右边电影介绍--> ' +
                        '<div class="movie-info-box Slider"><div class="movie-details"> <div class="details"> </div> </div> ' +
                        '<div class="on-now"> <div class="movie-img-s"> <img src/> </div> ' +
                        '<div class="on-now-name f"> <p class="title"></p> <p><i class="Hui-iconfont">&#xe6e6;</i>Playing...</p> </div> </div>' +
                        '<div class="mod-handle"><div class="add-collect mt-5"> <a class="like"><i class="Hui-iconfont">&#xe649;</i>Add to collection</a> </div>&nbsp;<span class="SeparationLine">|</span> &nbsp;' +
                        '<div class="downloadMeta"><a><i class="Hui-iconfont Hui-iconfont-down"></i>DownLoad</a></div> </div>' +
                        ' </div> </div><div class="channel-list-control"> <div class="s-div"> <span class="Hui-iconfont">&#xe63d;</span> </div>' +
                        ' <div class="s-div1" style="display: none;"> <span class="Hui-iconfont">&#xe67d;</span> </div> </div> <!--播放列表 结束-->')
                    $('.details').append('<div class="movie-name"><p>'+result.title+'<span class="score"><span class="score-l">'+parseInt(sco)+'</span>' +
                        '<span class="score-s">. '+sco[sco.length - 1] +'</span>score</span> </p> </div> ' +
                        '<div class="screened mt-5"> Release data：'+ result.year+' </div>  <div class="actor mt-5"> Action：<ul> <li><a>'+result.actor+'</a></li> </ul> </div> ' +
                        '<div class="Program mt-5"> <div class="btn">Source of information<i class="Hui-iconfont">&#xe6d5;</i></div> <p>'+result.description+'</p> </div> ' +
                        '<!--<div class="add-collect mt-5"> <a class="like"><i class="Hui-iconfont">&#xe649;</i>Add to collection</a> </div>-->');
                }

                $('.tele-info').css('display','none');
                $('.movie-img-s img').attr('src',result.thumbnail);
                $('.mod-player').append('<div class="live-player" id="a1" mediaId="'+result.id+'" columnId="'+result.columnId+'" meta="'+result.meta+'"></div> <div class="control-player"></div>');
                $('.on-now-name.f p.title').html(result.title);
                //add_collect();
                var str = $(".Program p").text();
                var s = str;
                if (str.length > 120) {
                    s = str.substring(0, 120) + "...";
                    $(".Program p").text(s);
                }
                if(lan=="zh"){
                    $("<a target='_blank' style='cursor: pointer;color:#CB242B' class='Show-More' href='detail?id="+mediaId+"&columnid="+columnId+"'>查看详情</a>").appendTo(".Program p");
                }else{
                    $("<a target='_blank' style='cursor: pointer;color:#CB242B' class='Show-More' href='detail?id="+mediaId+"&columnid="+columnId+"'>View detail</a>").appendTo(".Program p");
                }

            }
            //电视剧或者综艺 6为点播abr，3为系列电影
            else if(meta==2 ||meta==4 || meta==6 || meta==3){
                var sco = result.score/10;
                sco = sco.toFixed(1);
                $(".tele-info").html("");
                var hml='';
                sco.split('.');
                var Episodes = 0;
                if(meta==4){
                    //综艺
                    if(lan=="zh"){
                        $('.player').append('<!--播放列表开始--><!--综艺播放列表--> <div class="channel-list variety"><div class="show-tab"> ' +
                            '<ul> <li><a class="central-TV-tab active">选集</a></li> </ul> </div><!--右边电视剧选集--> <div class="variety-info-box Slider"> ' +
                            '<div class="variety-details"> <div class="details"> <div class="variety-name"><p>'+result.title+' ' +
                            '<span class="score"><span class="score-l">'+ parseInt(sco)+'</span><span class="score-s">.'+ sco[sco.length-1]+'</span>分</span></p>  </div> ' +
                            '<!--<div class="add-collect mt-5"><a class="like"><i class="Hui-iconfont">&#xe649;</i>加入收藏</a> </div>--> </div><div class="variety-list"> <ul> </ul></div></div>' +
                            '<div class="mod-handle"><div class="add-collect mt-5"> <a class="like"><i class="Hui-iconfont">&#xe649;</i>加入收藏</a> </div>&nbsp;<span class="SeparationLine">|</span> &nbsp;' +
                            '<div class="downloadMeta"><a><i class="Hui-iconfont Hui-iconfont-down"></i>下载</a></div></div> </div> </div> ' +
                            '<div class="channel-list-control"> <div class="s-div"> <span class="Hui-iconfont Hui-iconfont-slider-right"></span> </div> ' +
                            '<div class="s-div1" style="display: none;"> <span class="Hui-iconfont Hui-iconfont-slider-left"></span> </div><div class="mod-handle"></div> </div><!--播放列表 结束-->');
                    }else{
                        $('.player').append('<!--播放列表开始--><!--综艺播放列表--> <div class="channel-list variety"><div class="show-tab"> ' +
                            '<ul> <li><a class="central-TV-tab active">Episodes list</a></li> </ul> </div><!--右边电视剧选集--> <div class="variety-info-box Slider"> ' +
                            '<div class="variety-details"> <div class="details"> <div class="variety-name"><p>'+result.title+' ' +
                            '<span class="score"><span class="score-l">'+ parseInt(sco)+'</span><span class="score-s">.'+ sco[sco.length-1]+'</span>score</span></p>  </div> ' +
                            '<!--<div class="add-collect mt-5"><a class="like"><i class="Hui-iconfont">&#xe649;</i>Add to collection</a> </div>--> </div><div class="variety-list"> <ul> </ul></div></div>' +
                            '<div class="mod-handle"><div class="add-collect mt-5"> <a class="like"><i class="Hui-iconfont">&#xe649;</i>Add to collection</a> </div>&nbsp;<span class="SeparationLine">|</span> &nbsp;' +
                            '<div class="downloadMeta"><a><i class="Hui-iconfont Hui-iconfont-down"></i>DownLoad</a></div></div> </div> </div> ' +
                            '<div class="channel-list-control"> <div class="s-div"> <span class="Hui-iconfont Hui-iconfont-slider-right"></span> </div> ' +
                            '<div class="s-div1" style="display: none;"> <span class="Hui-iconfont Hui-iconfont-slider-left"></span> </div> </div><!--播放列表 结束-->');
                    }

                    for(var i=0; i<result.urls.length;i++) {
                        Episodes+=1;
                        hml+='<li episode="'+i+'" mediaId="'+result.id+'" url="'+result.urls[i].url+'" isfinal="'+ result.urls[0].isfinal+'" meta="'+ result.meta+'" title="'+result.urls[i].title+'" url_title="'+result.urls[i].title+'" columnId="'+result.columnId+'">' +
                            '<div class="num-content"> <p class="num-tit">'+result.urls[i].serial+' </p> </div> </li>';
                    }
                    $('.variety-list ul').html(hml);
                    if(lan=="zh"){
                        $('.tele-info').append('<div class="tele-img"><img src="'+result.image+'" title="'+result.title+'"/> <div class="Episodes"> <p>'+Episodes+'期</p></div> </div> <div class="tele-info-right"> <div class="tele-name-score"> ' +
                            '<span class="name">'+result.title+'</span> <span class="score"> <em class="l">'+parseInt(sco)+'</em><em class="s">.'+sco[sco.length - 1]+'</em> </span> </div> <div class="info mt-10"> 简介： <p>'+result.description+' </p> </div> </div>');
                    }else{
                        $('.tele-info').append('<div class="tele-img"><img src="'+result.image+'" title="'+result.title+'"/> <div class="Episodes"> <p>'+Episodes+' sessions</p></div> </div> <div class="tele-info-right"> <div class="tele-name-score"> ' +
                            '<span class="name">'+result.title+'</span> <span class="score"> <em class="l">'+parseInt(sco)+'</em><em class="s">.'+sco[sco.length - 1]+'</em> </span> </div> <div class="info mt-10"> Description： <p>'+result.description+' </p> </div> </div>');
                    }
                }
                else if(meta==2 || meta==6 || meta==3){
                    //电视剧
                    if(lan=="zh"){
                        $('.player').append('<!--播放列表开始--><!--电视剧列表--><div class="channel-list teleplay"> <div class="show-tab"> ' +
                            '<ul> <li><a class="central-TV-tab active">剧集列表</a></li> </ul> </div><!--右边电视剧选集--> ' +
                            '<div class="tele-info-box Slider"> <div class="tele-details"><div class="details"> <div class="tele-name"> <p>'+result.title+' ' +
                            '<span class="score"><span class="score-l">'+ parseInt(sco)+'</span><span class="score-s">.'+ sco[sco.length-1]+'</span>分</span></p> </div> ' +
                            '<!--<div class="add-collect mt-5"><a class="like"><i class="Hui-iconfont">&#xe649;</i>加入收藏</a></div>--><div class="episode-list"><ul></ul></div>' +
                            '</div></div><div class="mod-handle"><div class="add-collect mt-5"> <a class="like"><i class="Hui-iconfont">&#xe649;</i>加入收藏</a> </div>&nbsp;<span class="SeparationLine">|</span> &nbsp;' +
                            '<div class="downloadMeta"><a><i class="Hui-iconfont Hui-iconfont-down"></i>下载</a></div></div> </div></div><div class="channel-list-control"> <div class="s-div"> <span class="Hui-iconfont Hui-iconfont-slider-right"></span> </div> ' +
                            '<div class="s-div1" style="display: none;"> <span class="Hui-iconfont Hui-iconfont-slider-left"></span> </div> </div><!--播放列表 结束-->');
                    }else{
                        $('.player').append('<!--播放列表开始--><!--电视剧列表--><div class="channel-list teleplay"> <div class="show-tab"> ' +
                            '<ul> <li><a class="central-TV-tab active">Episodes list</a></li> </ul> </div><!--右边电视剧选集--> ' +
                            '<div class="tele-info-box Slider"> <div class="tele-details"><div class="details"> <div class="tele-name"> <p>'+result.title+' ' +
                            '<span class="score"><span class="score-l">'+ parseInt(sco)+'</span><span class="score-s">.'+ sco[sco.length-1]+'</span>score</span></p> </div> ' +
                            '<!--<div class="add-collect mt-5"><a class="like"><i class="Hui-iconfont">&#xe649;</i>Add to collection</a></div>--><div class="episode-list"><ul></ul></div>' +
                            '</div></div><div class="mod-handle"><div class="add-collect mt-5"> <a class="like"><i class="Hui-iconfont">&#xe649;</i>Add to collection</a> </div>&nbsp;<span class="SeparationLine">|</span> &nbsp;' +
                            '<div class="downloadMeta"><a><i class="Hui-iconfont Hui-iconfont-down"></i>DownLoad</a></div></div> </div></div><div class="channel-list-control"> <div class="s-div"> <span class="Hui-iconfont Hui-iconfont-slider-right"></span> </div> ' +
                            '<div class="s-div1" style="display: none;"> <span class="Hui-iconfont Hui-iconfont-slider-left"></span> </div> </div><!--播放列表 结束-->');
                    }
                    for(var i=0; i<result.urls.length;i++) {
                        Episodes+=1;
                        var serial=result.urls[i].serial;
                        if(serial.length==1){
                            serial="0"+result.urls[i].serial;
                        }
                        hml+='<li><a  episode="'+i+'" meta="'+ result.meta+'" url="'+result.urls[i].url+'" isfinal="'+result.urls[i].isfinal+'" title="'+result.title+' " url_title="'+result.urls[i].title+' " mediaId="'+result.id+'">'+serial+'</a></li>';
                    }
                    $('.episode-list ul').html(hml);
                    if(lan=="zh"){
                        $('.tele-info').append('<div class="tele-img"><img src="'+result.image+'" title="'+result.title+'"/> <div class="Episodes"> <p>'+Episodes+'集</p></div> </div> <div class="tele-info-right"> <div class="tele-name-score"> ' +
                            '<span class="name">'+result.title+'</span> <span class="score"> <em class="l">'+parseInt(sco)+'</em><em class="s">.'+sco[sco.length - 1]+'</em> </span> </div> <div class="info mt-10"> 简介： <p>'+result.description+' </p> </div> </div>');
                    }else{
                        $('.tele-info').append('<div class="tele-img"><img src="'+result.image+'" title="'+result.title+'"/> <div class="Episodes"> <p>'+Episodes+' episodes</p></div> </div> <div class="tele-info-right"> <div class="tele-name-score"> ' +
                            '<span class="name">'+result.title+'</span> <span class="score"> <em class="l">'+parseInt(sco)+'</em><em class="s">.'+sco[sco.length - 1]+'</em> </span> </div> <div class="info mt-10"> Description： <p>'+result.description+' </p> </div> </div>');
                    }

                }
                $('.mod-player').append('<div class="live-player" id="a1" mediaId="'+result.id+'" columnId="'+result.columnId+'" meta="'+result.meta+'"></div> <div class="control-player"></div>');
                $('.channel-name span').text($('.episode-list .active').attr('url_title'));
                var str = $(".info p").text();
                var s = str;
                if(str.length>160){
                    s=str.substring(0,160)+"......";
                    $(".info p").text(s);
                }
                if(lan=="zh"){
                    $("<a target='_blank' style='cursor: pointer;color:#CB242B' class='Show-More' href='detail?id="+mediaId+"&columnid="+columnId+"'>查看详情</a>").appendTo(".tele-info .info p");
                }else{
                    $("<a target='_blank' style='cursor: pointer;color:#CB242B' class='Show-More' href='detail?id="+mediaId+"&columnid="+columnId+"'>View detail</a>").appendTo(".tele-info .info p");
                }
            }
            change();
        });
        media.relate(columnId, 'guoziyun', {id: mediaId,lang:lan,size:12}, function (status, responseText){
            var html="";
            result=JSON.parse(responseText);
            if(result.length>0){
                for(var i=0;i<result.length;i++){
                    html+='<li><a href="play?id='+result[i].id+'&columnid='+result[i].columnId+'"> <div class="movie-img"> <img src="'+result[i].thumbnail+'" alt="'+result[i].title+'"/> </div> <div class="movie-name"> <p>'+result[i].title+'</p> </div> </a> </li>';
                }
                $('.recommend-movie ul').html(html);
            }
        });
        //嘉宾名字过长就省略
        $('.guests a').each(function () {
            var str = $(this).text();
            if(str.length>15){
                str = str.substring(0,15)+'...';
                $(this).text(str);
            }
        })
    }
    //试看5分钟弹出框
    $('.close').click(function () {
        $('.tips_box').css('display','none');
    })

    //播放器加载完成之后之行的函数
    function loadedHandler() {
        if (CKobject.getObjectById('ckplayer_a1').getType()) {
            addPlayListener();
        }
        else {
            addPlayListener();
        }
    }

    //每隔5秒存一下观看时间
    var  temp =0 ;
    function timeHandler(t) {
        var T = parseInt(t);
        if (T > -1 && T % 5 == 1 && temp != T) {
            temp = T;
            localStorage.setItem('Time', T);
            savePlayRecord(num,T);
        }
        if (t > -1) {
            var price = $('.site-container').attr('price');
            if (t >= 300 && price != 0) {
                CKobject.getObjectById('ckplayer_a1').videoPause();
                $('.tips_box').css('display', 'block');
                CKobject.getObjectById('ckplayer_a1').videoStop(0);
            }
        }
    }
    //增加播放监听
    function addPlayListener() {
        if (CKobject.getObjectById('ckplayer_a1').getType()) {//说明使用html5播放器
            CKobject.getObjectById('ckplayer_a1').addListener('play', playHandler);
        }
        else {
            CKobject.getObjectById('ckplayer_a1').addListener('play', 'playHandler');
        }
    }

    function playHandler() {
        //alert('因为注册了监听播放，所以弹出此内容，删除监听将不再弹出');
        removePlayListener();
        if(localStorage.getItem("time") && localStorage.getItem("seria")==num){
            CKobject.getObjectById('ckplayer_a1').videoSeek(localStorage.getItem("time"));
        }else{
            CKobject.getObjectById('ckplayer_a1').videoSeek(getTime());
        }
        addTimeListener();
    }
    //删除播放监听事件
    function removePlayListener() {
        if (CKobject.getObjectById('ckplayer_a1').getType()) {//说明使用html5播放器
            CKobject.getObjectById('ckplayer_a1').removeListener('play', playHandler);
        }
        else {
            CKobject.getObjectById('ckplayer_a1').removeListener('play', 'playHandler');
        }
    }
    //增加时间监听
    function addTimeListener() {
        if (CKobject.getObjectById('ckplayer_a1').getType()) {//说明使用html5播放器
            CKobject.getObjectById('ckplayer_a1').addListener('time', timeHandler);
        }
        else {
            CKobject.getObjectById('ckplayer_a1').addListener('time', 'timeHandler');
        }
    }

    //将观看的电影每隔5秒存一次
    function savePlayRecord(num,timeNow){
        var mediaId = $('#media').attr('mediaId');
        var columnId = $('#media').attr('columnId');
        var epgId=ServerConfig.epg;
        var meta = $('#media').attr('meta');
        var imgUrl = $('#media').attr('imgUrl');
        var title = $('#media').attr('title');
        var obj='',result='',media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg),enHistory=[],zhHistory=[], zhH='',enH='';
        if(getCookie("signUin")){
            if(lan=="zh"){
                if(localStorage.getItem("zhHistory")){
                    zhH=JSON.parse(localStorage.getItem("zhHistory"));
                }
                obj = {epgId:epgId,columnId:columnId,mediaId:mediaId,meta:meta,title:title,image:imgUrl,time:timeNow,seria:num,userId:localStorage.getItem("uin")};
                if(zhH.length>0){
                    for(var g=0;g<zhH.length;g++) {
                        if (zhH[g].epgId == epgId && zhH[g].columnId == columnId && zhH[g].mediaId == mediaId && zhH[i].userId==localStorage.getItem("uin")) {
                            zhH.splice(g,1);
                        }
                    }
                    if(zhH.length>0){
                        for(var d=0;d<zhH.length;d++) {
                            zhHistory.push(JSON.stringify(zhH[d]));
                        }
                    }
                }
                zhHistory.push(JSON.stringify(obj));
                localStorage.setItem("zhHistory","["+zhHistory+"]");
                media.detail(columnId, 'guoziyun', { id:mediaId,lang:"en" }, function (status, responseText){
                    if(localStorage.getItem("enHistory")){
                        enH=JSON.parse(localStorage.getItem("enHistory"));
                    }
                    result=JSON.parse(responseText);
                    obj = {epgId:epgId,columnId:columnId,mediaId:mediaId,meta:meta,title:result.title,image:result.image,time:timeNow,seria:num,userId:localStorage.getItem("uin")};
                    if(enH.length>0){
                        for(var g=0;g<enH.length;g++) {
                            if (enH[g].epgId == epgId && enH[g].columnId == columnId && enH[g].mediaId == mediaId && enH[g].userId==localStorage.getItem("uin")) {
                                enH.splice(g,1);
                            }
                        }
                        if(enH.length>0){
                            for(var d=0;d<enH.length;d++) {
                                enHistory.push(JSON.stringify(enH[d]));
                            }
                        }
                    }
                    enHistory.push(JSON.stringify(obj));
                    localStorage.setItem("enHistory","["+enHistory+"]");
                });
            }else{
                if(localStorage.getItem("enHistory")){
                    enH=JSON.parse(localStorage.getItem("enHistory"));
                }
               obj = {epgId:epgId,columnId:columnId,mediaId:mediaId,meta:meta,title:title,image:imgUrl,time:timeNow,seria:num,userId:localStorage.getItem("uin")};
                if(enH.length>0){
                    for(var h=0;h<enH.length;h++) {
                        if (enH[h].epgId == epgId && enH[h].columnId == columnId && enH[h].mediaId == mediaId && enH[h].userId==localStorage.getItem("uin")) {
                            enH.splice(h,1);
                        }
                    }
                    if(enH.length>0){
                        for(var q=0;q<enH.length;q++) {
                            enHistory.push(JSON.stringify(enH[q]));
                        }
                    }
                }
                enHistory.push(JSON.stringify(obj));
                localStorage.setItem("enHistory","["+enHistory+"]");
                media.detail(columnId, 'guoziyun', { id:mediaId,lang:"zh" }, function (status, responseText){
                    if(localStorage.getItem("zhHistory")){
                        zhH=JSON.parse(localStorage.getItem("zhHistory"));
                    }
                    result=JSON.parse(responseText);
                    obj = {epgId:epgId,columnId:columnId,mediaId:mediaId,meta:meta,title:result.title,image:result.image,time:timeNow,seria:num,userId:localStorage.getItem("uin")};
                    if(zhH.length>0){
                        for(var g=0;g<zhH.length;g++) {
                            if (zhH[g].epgId == epgId && zhH[g].columnId == columnId && zhH[g].mediaId == mediaId && zhH[g].userId==localStorage.getItem("uin")) {
                                zhH.splice(g,1);
                            }
                        }
                        if(zhH.length>0){
                            for(var d=0;d<zhH.length;d++) {
                                zhHistory.push(JSON.stringify(zhH[d]));
                            }
                        }
                    }
                    zhHistory.push(JSON.stringify(obj));
                    localStorage.setItem("zhHistory","["+zhHistory+"]");
                });
            }
        }
    }

    function getCollectInfo(epgId, columnId, mediaId){
        if($(".mod-player .live-player").html()==false){
            if(lan=="zh"){
                $(".mod-player .live-player").html("<div style='font-size: 16px;color: #fff;height: 450px;line-height: 450px;text-align: center;'>播放出错，请重新加载!</div>");
            }else{
                $(".mod-player .live-player").html("<div style='font-size: 16px;color: #fff;height: 450px;line-height: 450px;text-align: center;'>Play error, please reload</div>");
            }
        }
        if(getCookie("signUin")){
            if(lan=="zh"){
                if(localStorage.getItem("zhFavorite")){
                    var zhFavorite=JSON.parse(localStorage.getItem("zhFavorite"));
                    for(var i=0;i<zhFavorite.length;i++) {
                        if ( epgId==zhFavorite[i].epgId  && columnId ==zhFavorite[i].columnId  && mediaId ==zhFavorite[i].mediaId && localStorage.getItem("uin")==zhFavorite[i].userId ) {
                            $('.add-collect a').addClass('liked').html('<i class="Hui-iconfont">&#xe648;</i>已收藏');
                        }
                    }
                }
            }else{
                if(localStorage.getItem("enFavorite")){
                    var enFavorite=JSON.parse(localStorage.getItem("enFavorite"));
                    for(var k=0;k<enFavorite.length;k++) {
                        if ( epgId==enFavorite[k].epgId  &&  columnId==enFavorite[k].columnId  && mediaId== enFavorite[k].mediaId && localStorage.getItem("uin")==enFavorite[k].userId) {
                            $('.add-collect a').addClass('liked').html('<i class="Hui-iconfont">&#xe648;</i>Have been collected');
                        }
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
            $(".wrapper-main .recommend-tit p").html("您可能喜欢");
        }else{
            EN();
            $("footer ._footer").eq(0).removeClass("displayNone").siblings().addClass("displayNone");
            $(".wrapper-main .recommend-tit p").html("Guess you like");
        }
        $(this).addClass("active").siblings().removeClass("active");
        localStorage.setItem("lang",lan);
        detail();
        getInfo();
    })

</script>
</body>
</html>