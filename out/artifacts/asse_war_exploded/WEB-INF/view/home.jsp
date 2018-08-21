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
    <link href="public/css/home-style.css?v=${version}" rel="stylesheet">
    <link href="public/css/Common.css?v=${version}" rel="stylesheet">
    <style type="text/css">
        nav .nav .nav-main ul li a {
            color: #000;
            padding:0 8px;
        }
        .HOT-box .hot-box .hot-wrapper .s-right ul li a:hover {
            box-shadow: 0 1px 0 #d2d2d2;
        }
        .HOT-box .hot-box .hot-wrapper .s-right ul li a p {
            font-weight: normal;
            color:#000;
        }
    </style>
</head>

<body>
<jsp:include page="head.jsp" flush="true"/>

<!--图片轮播-->
<div id="carousel1" name="0">
    <div class="car_bigp">
    </div>
    <div class="car_click">
        <div class="car_c_title">
            <p></p>
        </div>
        <div class="car_c_smallpic">
        </div>
    </div>
</div>

<!--推荐区域-->
<div class="HOT-box">
</div>

<!--页脚-->
<jsp:include page="footer.jsp" flush="true"/>

<script type="text/javascript" src="public/js/jquery.js"></script>
<script type="text/javascript" src="public/js/qrcode.min.js"></script>
<script type="text/javascript" src="public/js/config.js?v=${version}"></script>
<script type="text/javascript" src="public/js/main.js?v=${version}"></script>
<script type="text/javascript" src="public/js/Epgs/libcolumn.js"></script>
<script type="text/javascript" src="public/js/Epgs/libmedia.js"></script>
<script type="text/javascript" src="public/js/Epgs/librcmb.js"></script>
<script type="text/javascript">
    var rgb_arr =[];
    var lan="en",timer;
    if(localStorage.getItem("lang")){
        lan=localStorage.getItem("lang");
        if(lan=="zh"){
            CH();
            $(".zh").addClass("active").siblings().removeClass("active");
            $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
        }else{
            EN();
        }
    }else{
        EN();
    }
    var titleArray=[];
    /*推荐轮播区域*/
    var result,resultRcmb;
    getInfo();
    getColumns();
    getRcmb();

    var i = 0;
    $(".focus-box li").mouseover(function () {
        $(this).addClass("ba");
        $(this).siblings("li").removeClass("ba");
        i = $(this).index();
        $(".media_box").eq(i).fadeIn(500).siblings(".media_box").fadeOut(0);
    });
    $(".prv").click(function () {
        if(i>0){
            i-=1;
        }
        $(".focus-box li").eq(i).addClass("ba").siblings("li").removeClass("ba");
        $(".media_box").eq(i).fadeIn(500).siblings(".media_box").fadeOut(0);
    });
    $(".next").click(function () {
        if(i<$(".media_box").length-1){
            i+=1;
        }
        $(".focus-box li").eq(i).addClass("ba").siblings("li").removeClass("ba");
        $(".media_box").eq(i).fadeIn(500).siblings(".media_box").fadeOut(0);
    });


    function getRcmb() {
        if(lan=="zh") {
            document.title="首页";
        }else {
            document.title="Home";
        }
        var rcmb = epgRcmb.init(ServerConfig.epgs, ServerConfig.epg);
        rcmb.get("0", 'guoziyun',{lang:lan},function(status,responseText){
            result=JSON.parse(responseText);
            if(result==''||result==undefined||result==null){
                $('#carousel1').addClass('displayNone');
                return false;
            }
            console.log(result);
            resultRcmb=result[0].rcmbItems;
            if(resultRcmb.length>0){
                var html="",htm="",rcmbL=1;
                html+='<a class="car_c_inpt1"><i class="Hui-iconfont Hui-iconfont-arrow2-left"></i></a>';
                for(var i=0;i<resultRcmb.length;i++){
                    if(resultRcmb[i].type==1){
                        if(rcmbL<7){
                            titleArray.push(resultRcmb[i].title);
                            htm+='<a href="list?columnid='+ getName(resultRcmb[i].remark) +'&name='+ resultRcmb[i].title +'"><img src="'+resultRcmb[i].image2+'"></a>';
                            html+='<img style="width:89px;height: 54px;" src="'+resultRcmb[i].image2+'">';
                            if(rcmbL==1){
                                $(".car_c_title p").html(resultRcmb[i].title);
                            }
                            rcmbL++;
                        }
                    }
                }
                html+='<a class="car_c_inpt2"><i class="Hui-iconfont Hui-iconfont-arrow2-right"></i></a>';
                $(".car_bigp").html(htm);
                $(".car_c_smallpic").html(html);
                $(".car_c_smallpic img:eq(0)").css("border","solid 2px #BB242B");
                if(rcmbL==2){
                    rgb_arr = new Array("rgb(198, 198, 198)");
                }else if(rcmbL==3){
                    rgb_arr = new Array("rgb(198, 198, 198)","rgb(238, 238, 238)");
                }else if(rcmbL==4){
                    rgb_arr = new Array("rgb(198, 198, 198)","rgb(238, 238, 238)","rgb(224, 232, 219)");
                }else if(rcmbL==5){
                    rgb_arr = new Array("rgb(198, 198, 198)","rgb(238, 238, 238)","rgb(224, 232, 219)","rgb(33, 27, 123)");
                }else if(rcmbL==6){
                    rgb_arr = new Array("rgb(198, 198, 198)","rgb(238, 238, 238)","rgb(224, 232, 219)","rgb(33, 27, 123)","rgb(46, 167, 220)");
                }else if(rcmbL==7){
                    rgb_arr = new Array("rgb(198, 198, 198)","rgb(238, 238, 238)","rgb(224, 232, 219)","rgb(33, 27, 123)","rgb(46, 167, 220)","rgb(184, 196, 239)");
                }
                //点击左箭头
                $(".car_c_inpt1").click(function(){
                    var showpicnum = $("#carousel1").attr("name");
                    if(showpicnum <= 0){
                        var eqnum = rcmbL-2;
                    }else{
                        var eqnum = showpicnum-1;
                    }
                    mouseRoll(rgb_arr,title_arr,eqnum);

                });
                //点击右箭头
                $(".car_c_inpt2").click(function(){
                    var showpicnum = $("#carousel1").attr("name");
                    //console.log(showpicnum);
                    if(showpicnum >= rcmbL-2){
                        var eqnum = 0;
                    }else{
                        var eqnum = showpicnum*1+1*1;
                    }
                    mouseRoll(rgb_arr,title_arr,eqnum);
                });
                //鼠标滑过小图
                $(".car_c_smallpic img").mouseenter(function(){
                    var eqnum = $(this).index()-1;
                    mouseRoll(rgb_arr,title_arr,eqnum);
                    clearInterval(timer);
                }).mouseleave(function(){
                    roll(rgb_arr,title_arr)
                });
                $("#carousel1 .car_bigp a").hide();
                $(".car_bigp a:eq(0)").fadeIn();
                roll(rgb_arr,title_arr);
            }
        })
        //点击搜索
        $('#sub_search').click(function() {
            var title = $('#search').val();
            if (title != '' && title != null) {
                window.location.href='search?wd=' + title;
            }else{
                $("#search").focus();
            }
        });
    }

    //图片轮播
    $("#carousel1").css("background-color","rgb(198, 198, 198)");

    //标题
    var title_arr=titleArray;
    //自动轮播
    function roll(rgb_arr,title_arr){
        timer=setInterval(function(){
            for(var i=0;i<=rgb_arr.length;i++){
                var nowpic = $("#carousel1 .car_bigp a").eq(i);
                if(nowpic.css("display") == "block"){
                    var showpicnum = i*1+1*1;
                    $("#carousel1 .car_bigp a").hide();
                    $(".car_c_smallpic img").css("border","");
                    if(showpicnum == rgb_arr.length){
                        //最后一张时,跳转到第一张
                        $("#carousel1 .car_bigp a").eq(0).fadeIn();
                        $("#carousel1").css("background-color",rgb_arr[0]);
                        $("#carousel1").attr("name",0);
                        $(".car_c_smallpic img").eq(0).css("border","solid 2px #BB242B");
                        $(".car_c_title p").html(title_arr[0]);
                    }else{
                        $("#carousel1 .car_bigp a").eq(showpicnum).fadeIn();
                        $("#carousel1").css("background-color",rgb_arr[showpicnum]);
                        $("#carousel1").attr("name",showpicnum);
                        $(".car_c_smallpic img").eq(showpicnum).css("border","solid 2px #BB242B");	//小图边框
                        $(".car_c_title p").html(title_arr[showpicnum]);	//标题
                    }
                    break;
                }
            }
        },10000);
    }

    //鼠标事件轮播方法
    function mouseRoll(rgb_arr,title_arr,eqnum){
        $(".car_c_smallpic img").css("border","");
        $(".car_c_smallpic img").eq(eqnum).css("border","solid 2px #BB242B");
        $("#carousel1 .car_bigp a").hide();
        $("#carousel1 .car_bigp a").eq(eqnum).fadeIn();
        $("#carousel1").css("background-color",rgb_arr[eqnum]);
        $(".car_c_title p").html(title_arr[eqnum]);
        //最新的name值
        $("#carousel1").attr("name",eqnum);
    }
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

    function getName(name) {
        var parameters = name.split("&");
        return parameters[0].substring(10);
    }
    $(".language a").bind("click",function () {
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
        getColumns();
        getRcmb();
        getInfo();
    })
</script>
</body>
</html>