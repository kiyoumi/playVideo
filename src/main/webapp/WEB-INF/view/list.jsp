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
    <link href="public/css/home-style.css?v=${version}" rel="stylesheet">
</head>
<body>
<!--头部-->
<jsp:include page="head.jsp" flush="true"/>
<p hidden="hidden" id="hidden"  areaId=""></p>

<section>
    <div class="On-Film-box">
        <div class="Film-box">
            <%--<div class="select-demand">
                <div class="demand-title"></div>
            </div>--%>
            <div class="filter-list">
                <div class="gradeChoose"></div>
                <div class="unionChoose"></div>
            </div>
            <div class="film-box">
                <ul></ul>
            </div>
        </div>
    </div>
    <div class="paging-box">
        <div id="pagination"></div>
        <input type="text" id="input_page"/>
        <a class="gopage" >Go</a>
    </div>
</section>

<!--页脚-->
<jsp:include page="footer.jsp" flush="true"/>

<script type="text/javascript" src="public/js/jquery.js"></script>
<script type="text/javascript" src="public/js/qrcode.min.js"></script>
<script type="text/javascript" src="public/js/main-mini.js?v=${version}"></script>
<script type="text/javascript" src="public/js/iscroll.js"></script>
<script type="text/javascript" src="public/js/jquery.cookie.js"></script>
<script type="text/javascript" src="public/js/config.js?v=${version}"></script>
<script type="text/javascript" src="public/js/main.js?v=${version}"></script>
<script type="text/javascript" src="public/js/Epgs/libcolumn.js"></script>
<script type="text/javascript" src="public/js/Epgs/libmedia.js"></script>
<script type="text/javascript" src="public/js/Epgs/libarea.js"></script>
<script type="text/javascript" src="public/js/Epgs/libcategory.js"></script>
<script type="text/javascript">
    var index;
    var lan="en";
    if(localStorage.getItem("lang")){
        lan=localStorage.getItem("lang");
        if(lan=="zh"){
            $(".zh").addClass("active").siblings().removeClass("active");
            CH();
            $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
        }else {
            EN();
        }
    }else {
        EN();
    }
    getInfo();
    getColumns();
    if(localStorage.getItem("time")){
        localStorage.removeItem("time");
    }

    function pagePush (Index, areaId) {
        if (Index != null && Index != '') {
            index = Index-1;
        }else{
            index = $('#hidden').attr('index')-1;
        }
        if (areaId == null || areaId == '') {
            areaId = $('#hidden').attr('areaid');
        }
        var media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg);
        media.get($('#hidden').attr('columnid'), 'guoziyun',{columnid: $('#hidden').attr('columnId'), pagesize: 12, pageindex: index, area: areaId,lang:lan}, function (status, responseText){
            console.log(responseText);
            var page = JSON.parse(responseText);
            var mediaList = page.list;
            if (mediaList != null && mediaList.length > 0) {
                movieTemplate( page);
            }else if(mediaList != null && mediaList.length==0){
                $('#hidden').attr('pagecount',page.pagecount);
                if(lan=="zh"){
                    $(".film-box ul").html("筛选出0条结果");
                }else{
                    $(".film-box ul").html("0 results were screened out");
                }
                bindLike();
            }
        });
    }

    function areas (tag) {
        var area = epgArea.init(ServerConfig.epgs);
        area.get('guoziyun', {lang:lan}, function (status, responseText) {
            var areas = JSON.parse(responseText);
            var htmlArea = '<ul class="areaChoose"><li>';
            if(lan=="zh"){
                htmlArea += '<span>地区：</span>';
                htmlArea += '<div class="tags-list" id="areas-list">';
                if ($('#hidden').attr('areaid') == '') {
                    htmlArea += '<a class="active" areaId="">全部</a>';
                } else {
                    htmlArea += '<a class="" areaId="">全部</a>';
                }
            }else{
                htmlArea += '<span>Area:</span>';
                htmlArea += '<div class="tags-list" id="areas-list">';
                if ($('#hidden').attr('areaid') == '') {
                    htmlArea += '<a class="active" areaId="">All</a>';
                } else {
                    htmlArea += '<a class="" areaId="">All</a>';
                }
            }
            for (var i = 0; i < areas.length; i++) {
                if (areas[i].id == $('#hidden').attr('areaid')) {
                    htmlArea += '<a class="active" areaId="' + areas[i].id + '">' + areas[i].title + '</a>';
                } else {
                    htmlArea += '<a class="" areaId="' + areas[i].id + '">' + areas[i].title + '</a>';
                }
            }
            htmlArea += '</div>';
            htmlArea += '</li></ul>';
            if($(".filter-list").hasClass("areaChoose")){
            }else{
                $(tag).append(htmlArea);
            }
            $('#areas-list a').bind('click', function () {
                $('#hidden').attr('index',"1");
                $(this).addClass("active").siblings().removeClass("active");
                $('#hidden').attr('areaid', $(this).attr('areaid'));
                pagePush('', $(this).attr('areaid'));
            });
        });
    }

    function category (tag,id) {
        var category = epgCategory.init(ServerConfig.epgs, ServerConfig.epg);
        category.get(id,'guoziyun', {lang:lan}, function (status, responseText) {
            var category = JSON.parse(responseText);
            var html = '<ul class="categoryChoose"><li>';
            if(lan=="zh"){
                html += '<span>类型：</span>';
                html += '<div class="tags-list" id="category-list">';
                if ($('#hidden').attr('categoryid') == '') {
                    html += '<a class="active" categoryId="">全部</a>';
                } else {
                    html += '<a class="" categoryId="">全部</a>';
                }
            }else{
                html += '<span>Category:</span>';
                html += '<div class="tags-list" id="category-list">';
                if ($('#hidden').attr('categoryid') == '') {
                    html += '<a class="active" categoryId="">All</a>';
                } else {
                    html += '<a class="" areaId="">All</a>';
                }
            }
            for (var i = 0; i < category.length; i++) {
                if (category[i].id == $('#hidden').attr('categoryid')) {
                    html += '<a class="active" categoryId="' + category[i].id + '">' + category[i].title + '</a>';
                } else {
                    html += '<a class="" categoryId="' + category[i].id + '">' + category[i].title + '</a>';
                }
            }
            html += '</div>';
            html += '</li></ul>';
            if($(".filter-list").hasClass("categoryChoose")){
            }else{
                $(tag).append(html);
            }
            $('#category-list a').bind('click', function () {
                $('#hidden').attr('index',"1");
                $(this).addClass("active").siblings().removeClass("active");
                $('#hidden').attr('categoryid', $(this).attr('categoryid'));
                //pagePush('', $(this).attr('areaid'));
            });
        });
    }

    $(function () {
        var _columnid=getParameterByName('columnid');
        //从url获取栏目id的名字
        var name = getParameterByName('name');
        $('#hidden').attr('index',1);
        //pagePush();
        getTitle(_columnid);

        getColumn(_columnid);
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
                }else{
                    $("#search").focus();
                }
            }
            $('.a').css({display:'none'})
        }
    });

    function getColumn(columnid) {
        var subject =getParameterByName('subject');
        $(".filter-list .gradeChoose,.filter-list .unionChoose").html("");
        var columnIds = epgColumn.init(ServerConfig.epgs,ServerConfig.epg);
        columnIds.get(columnid, 'guoziyun',{lang:lan}, function (status, responseText) {
            var htmlGrade = '';
            if(lan=="zh"){
                htmlGrade += '<h5 class="grade--L">科目：</h5>';
            }else{
                htmlGrade += '<h5 class="grade--L">Subject：</h5>';
            }
            htmlGrade += '<ul class="tags-list" id="grade-list">';
            var grade = JSON.parse(responseText);
            if(grade.length==0){
                $('#hidden').attr('pagecount',1);
                $('#hidden').attr('index',1);
                if(lan=="zh"){
                    $(".film-box ul").html("筛选出0条结果");
                }else{
                    $(".film-box ul").html("0 results were screened out");
                }
                bindLike();
            }
            for (var i = 0; i < grade.length; i++) {
                if(subject){
                    if(subject==grade[i].id){
                        htmlGrade += '<li><a class="'+ grade[i].id +' active gradeColumn" gradeId="' + grade[i].id + '" title="' + grade[i].title + '">';
                        if(grade[i].icon){
                            htmlGrade+='<img src="'+grade[i].icon+'">' + grade[i].title + '</a></li>';
                        }else{
                            htmlGrade+='<img src="public/images/subject.jpg">' + grade[i].title + '</a></li>';
                        }
                        union(grade[i].id);
                    }else{
                        htmlGrade += '<li><a class="'+ grade[i].id +' gradeColumn" gradeId="' + grade[i].id + '" title="' + grade[i].title + '">';
                        if(grade[i].icon){
                            htmlGrade+='<img src="'+grade[i].icon+'">' + grade[i].title + '</a></li>';
                        }else{
                            htmlGrade+='<img src="public/images/subject.jpg">' + grade[i].title + '</a></li>';
                        }
                    }
                }else{
                    if(i==0){
                        htmlGrade += '<li><a class="'+ grade[i].id +' active gradeColumn" gradeId="' + grade[i].id + '" title="' + grade[i].title + '">';
                        if(grade[i].icon){
                            htmlGrade+='<img src="'+grade[i].icon+'">' + grade[i].title + '</a></li>';
                        }else{
                            htmlGrade+='<img src="public/images/subject.jpg">' + grade[i].title + '</a></li>';
                        }
                        union(grade[i].id);
                    }else{
                        htmlGrade += '<li><a class="'+ grade[i].id +' gradeColumn" gradeId="' + grade[i].id + '" title="' + grade[i].title + '">';
                        if(grade[i].icon){
                            htmlGrade+='<img src="'+grade[i].icon+'">' + grade[i].title + '</a></li>';
                        }else {
                            htmlGrade += '<img src="public/images/subject.jpg">' + grade[i].title + '</a></li>';
                        }
                    }
                }
            }
            htmlGrade += '</ul>';
            var html = '';
            if(lan=="zh"){
                html += '<h5 class="chapterL">单元：</h5>';
            }else{
                html += '<h5 class="chapterL">Unit：</h5>';
            }
            html += '<ul class="tags-list" id="chapter-list">';
            html += '</ul>';
            $(".filter-list .gradeChoose").append(htmlGrade);
            $(".filter-list .unionChoose").append(html);
            $(".gradeColumn").unbind("click").bind("click",function () {
                $('#hidden').attr('index',1);
                union($(this).attr("gradeId"));
                $(this).addClass("active").parent("li").siblings().children("a").removeClass("active");
            })
        });
    }

    function union(id) {
        var unit=getParameterByName("unit");
        $(".filter-list .unionChoose ul").html("");
        var columnIds = epgColumn.init(ServerConfig.epgs,ServerConfig.epg);
        columnIds.get(id, 'guoziyun',{lang:lan}, function (status, responseText) {
            var union = JSON.parse(responseText);
            if(getParameterByName("unit")){
                $('#hidden').attr('columnId',getParameterByName('unit'));
            }else{
                $('#hidden').attr('columnId',id+"01");
            }
            var html = '';
            for(var k=0;k<union.length;k++){
                if(unit){
                    if(unit==union[k].id){
                        html+='<li><a class="active unionColumn" unionId=' + union[k].id + '>' + union[k].title + '</a></li>';
                    }else{
                        html+='<li><a class="unionColumn" unionId=' + union[k].id + '>' + union[k].title + '</a></li>';
                    }
                }else{
                    if(k==0){
                        html+='<li><a class="active unionColumn" unionId=' + union[k].id + '>' + union[k].title + '</a></li>';
                    }else{
                        html+='<li><a class="unionColumn" unionId=' + union[k].id + '>' + union[k].title + '</a></li>';
                    }
                }
            }
            $(".filter-list .unionChoose ul").append(html);
            pagePush();
            $(".unionColumn").unbind("click").bind("click",function () {
                var unionId=$(this).attr("unionId");
                $('#hidden').attr('index',1);
                $('#hidden').attr('columnId',unionId);
                $(this).addClass("active").parent("li").siblings().children("a").removeClass("active");
                pagePush();
            })
        })
    }

    //跳页
    function bindLike () {
        $(".paging-box").attr("curPage",$('#hidden').attr('index'));
        $(".paging-box").attr("pagecount",$('#hidden').attr('pagecount'));
        $(".paging-box").attr("columnid",$('#hidden').attr('columnId'));
        if(lan=="zh"){
            $("#pagination").html('<span class="jumppage">跳转到：</span>');
        }else{
            $("#pagination").html('<span class="jumppage">Jump:</span>');
        }
        Pagination.Init(document.getElementById('pagination'), {
            size: parseInt($('#hidden').attr('pagecount')), // pages size
            page: parseInt($('#hidden').attr('index')),  // selected page
            step: 3   // pages before and after current
        });
        $('a[name=paging]').bind('click', function () {
            var go = parseInt($(this).text());
            pagePush(go);
            $('#hidden').attr('index', go);
        });
        $('.gopage').click(function () {
            var str = $('#input_page').val();
            if (str == '') {
                return false;
            }
            if (!isNaN(str) && str >= 1 && str <= $('#hidden').attr('pagecount')) {
                pagePush(parseInt(str), $('#hidden').attr('areaid'));
                $('#hidden').attr('index', parseInt(str));
            }
        });

    }

    var Pagination = {
        code: '',
        Extend: function(data) {
            data = data || {};
            Pagination.size = data.size || 300;
            Pagination.page = data.page || 1;
            Pagination.step = data.step || 3;
        },

        Add: function(s, f) {
            for (var i = s; i < f; i++) {
                var n = i-1;
                Pagination.code += '<a name="paging">' + i + '</a>';
            }
        },

        Last: function () {
            Pagination.code += '<i>...</i><a name="paging">' + Pagination.size + '</a>';
        },

        First: function () {
            var pageSize = 12;
            Pagination.code += '<a name="paging">1</a><i>...</i>';
        },

        Click: function() {
            Pagination.page = +this.innerHTML;
            Pagination.Start();
        },

        Prev: function() {
            Pagination.page--;
            if (Pagination.page-1 < 1) {
                Pagination.page = 1;
            }
            $("#hidden").attr("index",Pagination.page);
            pagePush($("#hidden").attr("index"));
            Pagination.Start();
        },

        Next: function() {
            Pagination.page++;
            if (Pagination.page > Pagination.size) {
                Pagination.page = Pagination.size;
            }
            $("#hidden").attr("index",Pagination.page);
            pagePush($("#hidden").attr("index"));
            Pagination.Start();
        },

        Bind: function() {
            var a = Pagination.e.getElementsByTagName('a');
            for (var i = 0; i < a.length; i++) {
                if (+a[i].innerHTML === Pagination.page) a[i].className = 'current';
                a[i].addEventListener('click', Pagination.Click, false);
                if(a.length==1){
                    $('.prv').addClass('noClick');
                }
                if($(".current").html()==a.length){
                    $('.next').addClass('noClick');
                }
            }
        },

        Finish: function() {
            Pagination.e.innerHTML = Pagination.code;
            Pagination.code = '';
            Pagination.Bind();
        },

        Start: function() {
            if (Pagination.size < Pagination.step * 2 + 6) {
                Pagination.Add(1, Pagination.size + 1);
            }
            else if (Pagination.page < Pagination.step * 2 + 1) {
                Pagination.Add(1, Pagination.step * 2 + 4);
                Pagination.Last();
            }
            else if (Pagination.page > Pagination.size - Pagination.step * 2) {
                Pagination.First();
                Pagination.Add(Pagination.size - Pagination.step * 2 - 2, Pagination.size + 1);
            }
            else {
                Pagination.First();
                Pagination.Add(Pagination.page - Pagination.step, Pagination.page + Pagination.step + 1);
                Pagination.Last();
            }
            Pagination.Finish();
        },

        Buttons: function(e) {
            var nav = e.getElementsByTagName('a');
            nav[0].addEventListener('click', Pagination.Prev, false);
            nav[1].addEventListener('click', Pagination.Next, false);
        },

        // create skeleton
        Create: function(e) {
            var curPage = $('#hidden').attr('index');
            var pageCount = $('#hidden').attr('pagecount');
            var html='';
            if(lan=="zh"){
                html = [
                    '<a class="prv">上一页</a>',
                    '<span></span>',
                    '<a class="next">下一页</a>'
                ];
            }else{
                html = [
                    '<a class="prv noClick">Previous</a>',
                    '<span></span>',
                    '<a class="next">Next</a>'
                ];
            }
            e.innerHTML = html.join('');
            Pagination.e = e.getElementsByTagName('span')[0];
            Pagination.Buttons(e);
            if(curPage == 1){
                $('.prv').addClass('noClick');
            }else{
                $('.prv').removeClass('noClick');
            }
            if(curPage + 1 == pageCount){
                $('.next').addClass('noClick');
            }
        },

        // init
        Init: function(e, data) {
            Pagination.Extend(data);
            Pagination.Create(e);
            Pagination.Start();
        }
    };

    function getTitle(id) {
        var columnIds = epgColumn.init(ServerConfig.epgs,ServerConfig.epg);
        columnIds.list('guoziyun',{lang:lan}, function (status, responseText) {
            var list = JSON.parse(responseText);
            for(var j = 0; j < list.length ; j++){
                if(list[j].id==id){
                    $(".demand-title").html(list[j].title);
                    document.title=list[j].title;
                    return;
                }
            }
        });
    }

    //展示媒资
    function movieTemplate(page){
        var mediaList = page.list;
        var movie="";
        var epgId=ServerConfig.epg;
        for(var i = 0; i < mediaList.length; i++){
            movie += '<li name="media" mediaId="' + mediaList[i].id + '">';
            movie += '<a href="play?id=' + mediaList[i].id + '&columnid=' + mediaList[i].columnId + '&name='+getParameterByName("name")+'&title=' + mediaList[i].title + '" target="_blank">';
            movie += '<div class="movie-img">';
            movie += '<img src="' + mediaList[i].image + '" title="' + mediaList[i].title + '">';
            movie += '<i class="Hui-iconfont Hui-iconfont-bofang bofang"></i>';
            movie += '</div>';
            movie += '</a>';
            movie += '<div class="mask-text">';
            movie += '<em><i onclick="Like(this)" class="Hui-iconfont Hui-iconfont-like2 like" src="' + mediaList[i].image + '" title="' + mediaList[i].title + '" mediaId="' +mediaList[i].id+ '" columnid="' + mediaList[i].columnId + '" meta=" ' + mediaList[i].meta + '"></i></em>';
            movie += '</div>';
            movie += '<div class="movie-title">';
            movie += '<a href="play?id=' + mediaList[i].id + '&columnid=' + mediaList[i].columnId + '&name='+getParameterByName("name")+'&title=' + mediaList[i].title + '" target="_blank">' + mediaList[i].title + '</a>'
            movie += '</div>';
            movie += '</li>';
        }
        $('#hidden').attr('pagecount', page.pagecount);
        $('.film-box ul').html(movie);
        for(var k = 0; k < mediaList.length; k++){
            getCollectInfo(epgId,mediaList[k].columnId,mediaList[k].id,k);
        }
        $(".paging-box a:not(.prv,.next)").click(function () {
            $(this).addClass("active").parent("li").siblings("li").find("a").removeClass("active");
        });

        //更多选项和收起
        $(".gengduo").click(function () {
            $(".b").removeClass("none");
            $(this).css("display","none");
            $(".shouqi").css("display","block");
        });
        $(".shouqi").click(function () {
            $(".b").addClass("none");
            $(this).css("display","none");
            $(".gengduo").css("display","block");
        })

        $('.film-box .actor span').each(function () {
            var str = $(this).text();
            if(str.length > 6){
                str = str.substring(0,6)+'...';
            }
            $(this).text(str);
        });
        bindLike();
    }

    function Like(element) {
        var epgId=ServerConfig.epg;
        var obj='',result='',media = epgMedia.init(ServerConfig.epgs, ServerConfig.epg),enFavorite=[],zhFavorite=[];
        var mediaId=$(element).attr("mediaId"),columnId=$(element).attr("columnid"),imageSrc=$(element).attr("src"),title=$(element).attr("title"),meta=$(element).attr("meta");
        if(getCookie("signUin")){
            if($(element).attr('class')=='Hui-iconfont Hui-iconfont-like2 like'){
                if(lan=="zh"){
                    $(element).addClass('liked');
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
                    $(element).addClass('liked');
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
                    $(element).removeClass('liked');
                }else{
                    $(element).removeClass('liked');
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
    }

    $(".language a").bind("click",function () {
        lan=$(this).attr("lang");
        if(lan=="zh"){
            CH();
            $(".grade--L").html("科目：");
            $(".chapterL").html("单元：");
            $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
        }else{
            EN();
            $(".grade--L").html("Subject：");
            $(".chapterL").html("Unit：");
            $("footer ._footer").eq(0).removeClass("displayNone").siblings().addClass("displayNone");
        }
        $(this).addClass("active").siblings().removeClass("active");
        localStorage.setItem("lang",lan);
        pagePush();
        getInfo();
    })

    function getCollectInfo(epgId, columnId, mediaId,leng){
        if(getCookie("signUin")){
            if(lan=="zh"){
                if(localStorage.getItem("zhFavorite")){
                    var zhFavorite=JSON.parse(localStorage.getItem("zhFavorite"));
                    for(var i=0;i<zhFavorite.length;i++) {
                        if ( epgId==zhFavorite[i].epgId  && columnId ==zhFavorite[i].columnId  && mediaId ==zhFavorite[i].mediaId && localStorage.getItem("uin")==zhFavorite[i].userId ) {
                            $('.film-box ul li').eq(leng).children(".mask-text").children("em").children("i").addClass('liked');
                        }
                    }
                }
            }else{
                if(localStorage.getItem("enFavorite")){
                    var enFavorite=JSON.parse(localStorage.getItem("enFavorite"));
                    for(var k=0;k<enFavorite.length;k++) {
                        if ( epgId==enFavorite[k].epgId  &&  columnId==enFavorite[k].columnId  && mediaId== enFavorite[k].mediaId && localStorage.getItem("uin")==enFavorite[k].userId) {
                            $('.film-box ul li').eq(leng).children(".mask-text").children("em").children("i").addClass('liked');
                        }
                    }
                }
            }
        }
    }
</script>
</body>
</html>