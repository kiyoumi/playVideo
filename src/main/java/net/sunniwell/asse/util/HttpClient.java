package net.sunniwell.asse.util;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;


/**
 * Http请求封装
 *
 * @author: Jeremy Xie
 */
public class HttpClient {

    /**
     * 普通post请求
     *
     * @param url
     * @return
     */
    public static String post(String url, Map<String, String> params) {
        DefaultHttpClient httpclient = new DefaultHttpClient();
        String body = null;
        System.out.println("[CREATE POST]:" + url);
        HttpPost post = postForm(url, params);
        body = invoke(httpclient, post);
        httpclient.getConnectionManager().shutdown();
        return body;
    }

    /**
     * 鉴权post请求
     *
     * @param url
     * @param params
     * @param auths
     * @return
     */
    public static String authPost(String url,Map<String, String> params, Map<String, String> auths) {
        DefaultHttpClient httpclient = new DefaultHttpClient();
        String body = null;
        System.out.println("[CREATE AUTH POST]:" + url);
        HttpPost post = postForm(url,params);
        for (String key : auths.keySet()) {
            System.out.println(key+":"+auths.get(key).toString());
            post.setHeader(key, auths.get(key).toString());
        }
        body = invoke(httpclient, post);
        httpclient.getConnectionManager().shutdown();
        return body;
    }

    /**
     * 鉴权get请求
     *
     * @param url
     * @param auths
     * @return
     */
    public static String authGet(String url, Map<String, String> auths) {
        DefaultHttpClient httpclient = new DefaultHttpClient();
        String body = null;
        System.out.println("[CREATE AUTH GET]:" + url);
        HttpGet get = new HttpGet(url);
        for (String key : auths.keySet()) {
            System.out.println(key+":"+auths.get(key).toString());
            get.setHeader(key, auths.get(key).toString());
        }
        body = invoke(httpclient, get);
        httpclient.getConnectionManager().shutdown();
        return body;
    }

    /**
     * 普通get请求
     *
     * @param url
     * @return
     */
    public static String get(String url) {
        DefaultHttpClient httpclient = new DefaultHttpClient();
        String body = null;
        System.out.println("[CREATE GET]:" + url);
        HttpGet get = new HttpGet(url);
        body = invoke(httpclient, get);
        httpclient.getConnectionManager().shutdown();
        return body;
    }



    private static String invoke(DefaultHttpClient httpclient,
                                 HttpUriRequest httpost) {
        HttpResponse response = sendRequest(httpclient, httpost);
        String body = paseResponse(response);
        return body;
    }

    /**
     * 解析response
     *
     * @param response
     * @return
     */
    private static String paseResponse(HttpResponse response) {
        System.out.println("GET RESPONSE FROM SERVER..");
        HttpEntity entity = response.getEntity();
        System.out.println("RESPONSE STATUS: " + response.getStatusLine());
        String charset = EntityUtils.getContentCharSet(entity);
        System.out.println(charset);
        String body = null;
        try {
            body = EntityUtils.toString(entity);
            System.out.println(body);
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return body;
    }

    private static HttpResponse sendRequest(DefaultHttpClient httpclient,
                                            HttpUriRequest httpost) {
        HttpResponse response = null;
        try {
            response = httpclient.execute(httpost);
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }
        return response;
    }

    /**
     * form表单式提交
     *
     * @param url
     * @param params
     * @return
     */
    private static HttpPost postForm(String url, Map<String, String> params) {
        HttpPost httpost = new HttpPost(url);
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        Set<String> keySet = params.keySet();
        for (String key : keySet) {
            nvps.add(new BasicNameValuePair(key, params.get(key)));
        }
        try {
            httpost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return httpost;
    }

}
