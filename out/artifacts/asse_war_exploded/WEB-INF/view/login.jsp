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
    <title>schoolnet</title>
    <link href="public/Icon/iconfont.css" rel="stylesheet">
    <link href="public/css/login.css?v=${version}" rel="stylesheet">
    <link rel="icon" href="public/images/logo.png" type="image/x-icon"/>
    <style type="text/css">
        h5{
            font-weight:normal;
        }
    </style>
</head>
<body>
<div class="language" style="float:right;color: #fff;margin-right: 20px;font-size: 14px;">
    <a class="select" lang="en">English</a>
    &nbsp;|&nbsp;
    <a lang="zh">中文</a>
</div>
<div class="head choose">
    <section class="login_main">
        <div class="login_box">
            <h3><a href="" title="Click to the home page"><img src="public/images/logow.png" style="width:250px;"></a></h3>
            <h5>Login to enjoy better video services</h5>
            <div class="border"></div>
            <div class="input_box">
                <div class="sign1" style="position:absolute;left:30px;color:red">
                </div>
                <div style="display: inline-block;width: 340px;margin: auto;text-align:left;color: #fff;">
                    <a style="font-size: 18px;color: #fff;">Account Login</a>
                </div>
                <div class="Mobile">
                    <span class="Hui-iconfont Hui-iconfont-phone"></span>
                    <input type="text" placeholder="Account" class="LMobile"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="password">
                    <span class="Hui-iconfont Hui-iconfont-key"></span>
                    <input type="password" placeholder="Password" class="LPassword"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <%--<div class="check">
                    <div style="color:#fff;">
                        <input type="checkbox" checked="checked" id="autoLogin"/><span>AutoLogin</span>
                    </div>
                </div>--%>
                <div>
                    <a class="login">Login</a>
                </div>
                <div style="display: inline-block;width: 340px;margin: auto;text-align: right;color: #fff;">
                    <a class="registerBtn" style="margin-right: 5px;">Register</a><%--|<a class="getForget" style="margin-left: 5px;">Retrieve Password</a>--%>
                </div>
            </div>
        </div>
    </section>
    <section class="register_main displayNone">
        <div class="register_box">
            <h3><a href="" title="Click to the home page"><img src="public/images/logow.png" style="width:250px;"></a></h3>
            <h5>Login to enjoy better video services</h5>
            <div class="border"></div>
            <div class="input_box">
                <div class="sign1" style="position:absolute;left:30px;color:red">
                </div>
                <div style="display: inline-block;width: 340px;margin: auto;text-align:left;color: #fff;">
                    <a style="font-size: 18px;">Register</a>
                </div>
                <div class="user_name">
                    <span class="Hui-iconfont Hui-iconfont-avatar2"></span>
                    <input type="text" placeholder="Username" class="RUsername"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="Mobile">
                    <span class="Hui-iconfont Hui-iconfont-phone"></span>
                    <input type="text" placeholder="Account" class="RMobile"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="password">
                    <span class="Hui-iconfont Hui-iconfont-key"></span>
                    <input type="password" placeholder="Password" class="RPassword"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="password_confirm">
                    <span class="Hui-iconfont Hui-iconfont-suoding"></span>
                    <input type="password" placeholder="Confirm Password" class="RCPassword"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="check">
                    <input type="checkbox" checked="checked" class="Rcheck"/><span>Agree to the terms of service</span>
                </div>
                <div class="reg">
                    <a class="register">Register</a>
                </div>
                <div style="display: inline-block;width: 340px;margin: auto;text-align: right;color: #fff;">
                    <a class="loginBtn" style="margin-right: 5px;">Login</a><%--|<a class="getForget" style="margin-left: 5px;">Retrieve Password</a>--%>
                </div>
            </div>

        </div>
    </section>
</div>
<div class="head displayNone">
    <section class="login_main">
        <div class="login_box">
            <h3><a href="" title="点击去首页"><img src="public/images/logow.png" style="width:250px;"></a></h3>
            <h5>登录享受更好的视频服务</h5>
            <div class="border"></div>
            <div class="input_box">
                <div class="sign1" style="position:absolute;left:30px;color:red">
                </div>
                <div style="display: inline-block;width: 340px;margin: auto;text-align:left;color: #fff;">
                    <a style="font-size: 18px;color: #fff;">账号登录</a>
                </div>
                <div class="Mobile">
                    <span class="Hui-iconfont Hui-iconfont-phone"></span>
                    <input type="text" placeholder="Account" class="LMobile"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="password">
                    <span class="Hui-iconfont Hui-iconfont-key"></span>
                    <input type="password" placeholder="Password" class="LPassword"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <%--<div class="check" style="text-indent: -237px;">
                    <div style="color:#fff;">
                        <input type="checkbox" checked="checked" id="autoLogin"/><span>下次自动登录</span>
                    </div>
                </div>--%>
                <div>
                    <a class="login">立即登录</a>
                </div>
                <div style="display: inline-block;width: 340px;margin: auto;text-align: right;color: #fff;">
                    <a class="registerBtn" style="margin-right: 5px;">立即注册</a><%--|<a class="getForget" style="margin-left: 5px;">找回密码</a>--%>
                </div>
            </div>
        </div>
    </section>
    <section class="register_main displayNone">
        <div class="register_box">
            <h3><a href="" title="点击去首页"><img src="public/images/logow.png" style="width:250px;"></a></h3>
            <h5>登录享受更好的视频服务</h5>
            <div class="border"></div>
            <div class="input_box">
                <div class="sign1" style="position:absolute;left:30px;color:red">
                </div>
                <div style="display: inline-block;width: 340px;margin: auto;text-align:left;color: #fff;">
                    <a style="font-size: 18px;">注册</a>
                </div>
                <div class="user_name">
                    <span class="Hui-iconfont Hui-iconfont-avatar2"></span>
                    <input type="text" placeholder="Username" class="RUsername"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="Mobile">
                    <span class="Hui-iconfont Hui-iconfont-phone"></span>
                    <input type="text" placeholder="Account" class="RMobile"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="password">
                    <span class="Hui-iconfont Hui-iconfont-key"></span>
                    <input type="password" placeholder="Password" class="RPassword"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>
                <div class="password_confirm">
                    <span class="Hui-iconfont Hui-iconfont-suoding"></span>
                    <input type="password" placeholder="Confirm Password" class="RCPassword"/>
                    <div class="info">
                        <p class="triangle-isosceles top text">For example</p>
                    </div>
                </div>

                <div class="check" style="text-indent: -205px;">
                    <input type="checkbox" checked="checked" class="Rcheck"/><span>同意本站服务条款</span>
                </div>
                <div class="reg">
                    <a class="register">立即注册</a>
                </div>
                <div style="display: inline-block;width: 340px;margin: auto;text-align: right;color: #fff;">
                    <a class="loginBtn" style="margin-right: 5px;">立即登录</a><%--|<a class="getForget" style="margin-left: 5px;">找回密码</a>--%>
                </div>
            </div>

        </div>
    </section>
</div>

<script type="text/javascript" src="public/js/jquery.js"></script>
<script type="text/javascript" src="public/js/jquery.cookie.js"></script>
<script type="text/javascript" src="public/js/sha256.js"></script>
<script type="text/javascript" src="public/js/config.js?v=${version}"></script>
<script type="text/javascript">
    var loginFlag=true;
    var lang="en";
    if(localStorage.getItem("lang")){
        lang=localStorage.getItem("lang");
        if(lang=="zh"){
            $(".head").eq(1).addClass("choose").removeClass("displayNone").siblings().addClass("displayNone").removeClass("choose");
            $(".language").removeClass("displayNone");
            $(".language a").eq(1).addClass("select").siblings().removeClass("select");
        }
    }
    if(getParameterByName("R")==1){
        $(".register_main").removeClass("displayNone").siblings().addClass("displayNone");
    }

    if(sessionStorage.getItem("accesssvr")=="" || sessionStorage.getItem("accesssvr")==null){
        $.get('media/svr',function (data) {
            console.log(data);
            if(data.code==0) {
                if(data.result.length>0){
                    sessionStorage.setItem("accesssvr",data.result[0].host+':'+data.result[0].http_port);
                }
            }
        })
    }

    $('.login_main .LMobile').bind({
        focus:function(){
            $('.choose .login_main .Mobile .info').css('display','none');
        },
        blur:function(){
            var tel = $('.choose .login_main .LMobile').val();
            if(tel == ''){
                $('.choose .login_main .Mobile .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .login_main .Mobile .info .text').text('请输入帐号！');
                }else{
                    $('.choose .login_main .Mobile .info .text').text('Enter account');
                }
            }
        }
    });
    $('.login_main .LPassword').bind({
        focus:function(){
            $('.choose .login_main .password .info').css('display','none');
            $('.choose .login_main .sign1').css('display','none');
        },
        blur:function(){
            var Password = $('.choose .login_main .LPassword').val();
            if(Password == ''){
                $('.choose .login_main .password .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .login_main .password .info .text').text('请输入密码！');
                }else{
                    $('.choose .login_main .password .info .text').text('Enter password');
                }
            } else if(Password.length<6){
                $('.choose .login_main .password .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .login_main .password .info .text').text('密码不小于6个字符！');
                }else{
                    $('.choose .login_main .password .info .text').text('Password is no less than 6 characters');
                }
            }else if(Password.length>16){
                $('.choose .login_main .password .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .login_main .password .info .text').text('密码不大于16个字符！');
                }else{
                    $('.choose .login_main .password .info .text').text('Password is no more than 16 characters');
                }
            }
        }
    });
    /*点击进行登录*/
    $('.login_main .login').unbind("click").bind("click",function(){
        if(loginFlag){
            login();
        }
    })

    function login() {
        $(".choose .login_main input").each(function(){
            if($(this).val()==""){
                $(this).parent().find(".info").css('display','block');
                if(lang=="zh"){
                    $(this).parent().find(".info .text").text('内容不能为空!');
                }else{
                    $(this).parent().find(".info .text").text('Content cannot be empty!');
                }
            }
        });
        var i=0;
        $(".choose .login_main .info").each(function(){
            var aa=$(this).css("display");
            if(aa=="block"){
                i++;
            }
        });
        if(i==0){
            var phone = $('.choose .login_main .LMobile').val();
            var password = $('.choose .login_main .LPassword').val();
            var type=0;
            $.ajax({
                type: 'POST',
                url: 'http://'+sessionStorage.getItem("accesssvr")+'/service/user/login',
                data:'type='+type+'&uid='+phone+'&passwd='+password+'&ttype=7&tid=&nickname=&photo=',
                success:function (data) {
                    if(data.code==0){
                        loginFlag=false;
                        if(lang=="zh"){
                            $(".login").html("登录成功");
                        }else{
                            $(".login").html("Login success");
                        }
                        localStorage.setItem("uin",data.result.uin);
                        localStorage.setItem("tin",data.result.tin);
                        localStorage.setItem("token",data.result.token);
                        document.cookie ="signUin="+ escape (SHA256(data.result.uin+password)) + ";max-age=" + 15*60;
                        window.setTimeout(function (){
                            window.location.href = "";
                        }, 1500);
                    }else{
                        if(lang=="zh"){
                            alert('登录失败');
                        }else{
                            alert("Login failed")
                        }
                    }
                },
                error: function() {
                    if(lang=="zh"){
                        alert('登录失败');
                    }else{
                        alert("Login failed")
                    }

                }
            })
        }
    }

    $('.register_main .RUsername').bind({
        focus:function(){
            $('.choose .register_main .Username .info').css('display','none');
        },
        blur:function(){
            var Username = $('.choose .register_main .RUsername').val();
            if(Username == ''){
                $('.choose .register_main .user_name .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .user_name .info .text').html('请输入用户名！');
                }else{
                    $('.choose .register_main .user_name .info .text').html('Enter username');
                }
            }else if(Username!= Username.replace(/[^a-zA-Z0-9-_]/g, '')){
                $('.choose .register_main .user_name .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .user_name .info .text').text('用户名只能由字母数字和下划线组成！');
                }else{
                    $('.choose .register_main .user_name .info .text').text('Username only numbers, letters and underlines');
                }
            }else if(Username.length<6){
                $('.choose .register_main .user_name .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .user_name .info .text').html('用户名长度不能小于6！');
                }else{
                    $('.choose .register_main .user_name .info .text').html('Username is no less than 6 characters');
                }
            }else if(Username.length>16) {
                $('.choose .register_main .user_name .info').css('display', 'block');
                if (lang == "zh") {
                    $('.choose .register_main .user_name .info .text').html('用户名长度不能大于16！');
                } else {
                    $('.choose .register_main .user_name .info .text').html('Username is no more than 16 characters');
                }
            }
        }
    });
    $('.register_main .RPassword').bind({
        focus:function(){
            $('.choose .register_main .Password .info').css('display','none');
        },
        blur:function(){
            var Password = $('.choose .register_main .RPassword').val();
            if(Password == ''){
                $('.choose .register_main .password .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .password .info .text').text('请输入密码！');
                }else{
                    $('.choose .register_main .password .info .text').text('Enter password');
                }
            }else if(Password.length<6){
                $('.choose .register_main .password .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .password .info .text').text('密码不小于6个字符！');
                }else{
                    $('.choose .register_main .password .info .text').text('Password is no less than 6 characters');
                }
            }else if(Password.length>16) {
                $('.choose .register_main .password .info').css('display', 'block');
                if (lang == "zh") {
                    $('.choose .register_main .password .info .text').text('密码不大于16个字符！');
                } else {
                    $('.choose .register_main .password .info .text').text('Password is no more than 16 characters');
                }
            }
        }
    });
    $('.register_main .RCPassword').bind({
        focus:function(){
            $('.choose .register_main .CPassword .info').css('display','none');
        },
        blur:function(){
            var Password = $('.choose .register_main .RPassword').val();
            var CPassword = $('.choose .register_main .RCPassword').val();
            if(CPassword == ''){
                $('.choose .register_main .password_confirm .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .password_confirm .info .text').text('请输入确认密码！');
                }else{
                    $('.choose .register_main .password_confirm .info .text').text('Enter password again');
                }
            } else if(CPassword != Password){
                $('.choose .register_main .password_confirm .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .password_confirm .info .text').text('输入的两次密码不同！');
                }else{
                    $('.choose .register_main .password_confirm .info .text').text('The two password entered is different');
                }
            }
        }
    });
    $('.register_main .RMobile').bind({
        focus:function(){
            $('.choose .register_main .Mobile .info').css('display','none');
            $('.choose .register_main .phone-code .info').css('display','none');
        },
        blur:function(){
            var tel = $('.choose .register_main .RMobile').val();
            var m = /^0?1[3|4|5|7|8][0-9]\d{8}$/;
            var pattern =/^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
            if(tel == ''){
                $('.choose .register_main .Mobile .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .Mobile .info .text').text('请输入帐号！');
                }else{
                    $('.choose .register_main .Mobile .info .text').text('Enter account');
                }
            }
            else if(tel!= tel.replace(/[^a-zA-Z0-9-_]/g, '')){
                $('.choose .register_main .Mobile .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .Mobile .info .text').text('帐号只能由字母数字和下划线组成！');
                }else{
                    $('.choose .register_main .Mobile .info .text').text('Account only numbers, letters and underlines');
                }
            }else if(tel.length<6){
                $('.choose .register_main .Mobile .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .register_main .Mobile .info .text').html('帐号长度不能小于6！');
                }else{
                    $('.choose .register_main .Mobile .info .text').html('Account is no less than 6 characters');
                }
            }else if(tel.length>16) {
                $('.choose .register_main .Mobile .info').css('display', 'block');
                if (lang == "zh") {
                    $('.choose .register_main .Mobile .info .text').html('帐号长度不能大于16！');
                } else {
                    $('.choose .register_main .Mobile .info .text').html('Account is no more than 16 characters');
                }
            }
            else{
                $.get('http://'+sessionStorage.getItem("accesssvr")+"/service/user/check?type=0&id="+tel,function (data) {
                    if(data.code==0){
                    }else{
                        $('.choose .register_main .Mobile .info').css('display','block');
                        if(lang=="zh"){
                            $('.choose .register_main .Mobile .info .text').text('帐号已注册！');
                        }else{
                            $('.choose .register_main .Mobile .info .text').text('Account has been registered');
                        }
                    }
                })
            }
        }
    });
    $('.register').bind("click",function(){
        $(".choose .register_main input").each(function(){
            if($(this).val()==""){
                $(this).parent().find(".info").css('display','block');
                if(lang=="zh"){
                    $(this).parent().find(".info .text").text('内容不能为空!');
                }else{
                    $(this).parent().find(".info .text").text('Content cannot be empty!');
                }
            }
        });
        var i=0;
        $(".choose .register_main .info").each(function(){
            var aa=$(this).css("display");
            if(aa=="block" && $(this).parent().css("display")=="block"){
                i++;
            }
        });
        if(i==0){
            var username = $('.choose .register_main .RUsername').val();
            var password = $('.choose .register_main .RPassword').val();
            var tel = $('.choose .register_main .RMobile').val();
            reg(0,username,tel,password);
        }
    })

    //获取验证码
    $('.code-btn').click(function () {
        var index,type;
        var phone="";
        if($(this).attr("type") == "register"){
            index=0;
            phone=$(".choose .register_main .RMobile").val().replace(/^\s+|\s+$/g,'');
        }else{
            index=1;
            phone=$(".choose .find_main #Mobile").val().replace(/^\s+|\s+$/g,'');
        }
        type=index+1;
        var reg = /^0?1[3|4|5|7|8][0-9]\d{8}$/;
        if (reg.test(phone)) {
            pin(phone,type,$('.code-btn')[index]);
        }else{
            $('.choose .Mobile .info').css('display','block');
            if(lang=="zh"){
                $('.choose .Mobile .info .text').text('请输入正确的手机号码！');
            }else{
                $('.choose .Mobile .info .text').text('Enter correct moblie');
            }

        }
    });

    document.onkeydown = function(event) {
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if (e && e.keyCode == 13) {
            if($(".choose .login_main").hasClass("displayNone")==false && loginFlag){
                login();
            }
        }
    }


    $(".registerBtn").unbind("click").bind("click",function () {
        $(".register_main").removeClass("displayNone").siblings().addClass("displayNone");
        $(".register_main .info").css('display','none');
        $(".register_main input").val("");
        if(lang=="zh"){
            $(".reg a.register").html("立即注册");
        }else{
            $(".reg a.register").html("Register");
        }

    })
    $(".loginBtn").unbind("click").bind("click",function () {
        loginFlag=true;
        $(".login_main").removeClass("displayNone").siblings().addClass("displayNone");
        $(".login_main .info").css('display','none');
        $(".login_main input").val("");
    })
    $(".getForget").unbind("click").bind("click",function () {
        $(".find_main").removeClass("displayNone").siblings().addClass("displayNone");
        $(".find_main .info").css('display','none');
        $(".find_main input").val("");
        if(lang=="zh"){
            $(".get .confirmFind").html("确认");
        }else{
            $(".get .confirmFind").html("Submit");
        }

    })

    function reg(type,username,phone,password,code) {
        if(code=="undefind" || code==null){
            code="";
        }
        $.ajax({
            type: 'POST',
            url: 'http://'+sessionStorage.getItem("accesssvr")+'/service/user/register',
            data:'type='+type+'&id='+phone+'&passwd='+password+'&nickname='+username+'&photo=&sex&channel&vcode='+code+'',
            success:function (result) {
                if(result.code==0){
                    if(type==0 || type==1){
                        if(lang=="zh"){
                            $(".choose .register").html("注册成功");
                        }else{
                            $(".choose .register").html("Register success");
                        }
                    }else if(type==2){
                        if(lang=="zh"){
                            $(".choose .register").html("注册成功,请前往邮箱激活");
                        }else{
                            $(".choose .register").html("Register success，please go to mailbox activation");
                        }
                    }
                    window.setTimeout(function () {
                        $(".choose .login_main").removeClass("displayNone").siblings().addClass("displayNone");
                    },1000);
                }else{
                    alert(result.msg);
                }
            },
            error: function() {
                if(lang=="zh"){
                    alert('注册失败');
                }else{
                    alert('Register failed');
                }

            }
        })

    }

    // type:1-------用户注册验证码，type:2-------重设密码验证码
    function pin(phone,type,target){
        $.get('http://'+sessionStorage.getItem("accesssvr")+'/service/vcode/get?type='+type+'&mobile='+phone+'',function(data){
            if(data.code == 0){
                setTime(target);
            }else{
                $('.choose .phone-code .info').css('display','block');
                if(lang=="zh"){
                    $('.choose .phone-code .info .text').text('获取失败！');
                }else{
                    $('.choose .phone-code .info .text').text('Get failed');
                }

            }
        });
    }

    //60s cut down
    var countdown =60;
    var setTime=function(target){
        var _timer =setTimeout(function() {
            setTime(target)
        },1000);
        if (countdown == 0) {
            if(lang=="zh"){
                target.innerHTML ='获取验证码';
            }else{
                target.innerHTML ='Get verification Code';
            }
            countdown = 60;
            clearTimeout(_timer);
        } else {
            if(lang=="zh"){
                target.innerHTML ="重新发送(" + countdown + ")";
            }else{
                target.innerHTML ="Resend(" + countdown + ")";
            }
            countdown--;
        }
    };

    $('.input_box input').focus(function () {
        $(this).next(".info").fadeOut();
    })
    //点击叉关闭提示框
    $('.info .close').click(function () {
        $(this).parent().fadeOut();
    })

    function getParameterByName (name) {
        name = name.replace(/[\[]/, '\\\[').replace(/[\]]/, '\\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)'),
            results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    $(".language a").bind("click",function () {
        $(this).addClass("select").siblings().removeClass("select");
        lang=$(this).attr("lang");
        if(lang=="zh"){
            $(".get .confirmFind").html("确认");
            $(".reg a.register").html("立即注册");
            $(".head").eq(1).addClass("choose").removeClass("displayNone").siblings().addClass("displayNone").removeClass("choose");
        }else{
            $(".get .confirmFind").html("Submit");
            $(".reg a.register").html("Register");
            $(".head").eq(0).addClass("choose").removeClass("displayNone").siblings().addClass("displayNone").removeClass("choose");
        }
        localStorage.setItem("lang",lang);
        $(".language").removeClass("displayNone");
    })
</script>
</body>
</html>
