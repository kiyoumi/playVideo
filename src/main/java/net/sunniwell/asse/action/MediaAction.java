package net.sunniwell.asse.action;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import net.sunniwell.asse.model.assist.ResultModel;
import net.sunniwell.asse.util.HttpClient;
import net.sunniwell.asse.util.ToolUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * 媒体资源控制类
 *
 * @author: Jeremy Xie
 */

@Controller
@RequestMapping(value = "/media")
public class MediaAction {

    @Resource
    private Map<String, String> sysConfig;// 对应nplat.properties文件

    /**
     * 获取接入层
     *
     * @return
     */
    @RequestMapping(value = "/svr")
    @ResponseBody
    public Object svr(HttpServletRequest httpRequest)  {
        ResultModel result = new ResultModel();
        //System.out.println(sysConfig.get("bls")+"service/server/get");
        String getRes = HttpClient.get(sysConfig.get("bls")+"service/server/get");
        if (StringUtils.isNoneBlank(getRes)) {
            result = JSONObject.parseObject(getRes, ResultModel.class);
        } else {
            result.setCode(-3);
            result.setMsg("服务器超时");
        }
        System.out.println(result);
        HttpSession session = httpRequest.getSession();
        session.setAttribute("accesssvr", result);
        return result;
    }

    /**
     * 用户基本信息
     *
     * @param uin
     * @param signUin
     * @return
     */
    @RequestMapping(value = "/info")
    @ResponseBody
    public Object info(String uin, String signUin,HttpServletRequest httpRequest) {
        ResultModel result = new ResultModel();
        if (StringUtils.isAnyBlank(uin, signUin)) {
            result.setCode(-2);
            result.setMsg("参数不能为空");
            return result;
        }
        //java
        HttpSession session = httpRequest.getSession();
        ResultModel r  = (ResultModel)session.getAttribute("accesssvr");
        JSONArray jsonArray = null;
        if(r != null && r.getResult() != null) {
            jsonArray = (JSONArray)(r.getResult());
        }else{
            ResultModel resultModel = new ResultModel(0, "success", null);
            String getRes = HttpClient.get(sysConfig.get("bls")+"service/server/get");
            if (StringUtils.isNoneBlank(getRes)) {
                resultModel = JSONObject.parseObject(getRes, ResultModel.class);
                jsonArray = (JSONArray)(resultModel.getResult());
            } else {
                resultModel.setCode(-3);
                resultModel.setMsg("服务器超时");
            }
            System.out.println(result);
            session.setAttribute("accesssvr", resultModel);
        }
        if(jsonArray != null){
            JSONObject jsonObject = jsonArray.getJSONObject(0);
            String authUrl =  "http://"+jsonObject.get("host")+ ":" +jsonObject.get("http_port") + "/service/user/info?uin=" + uin + "";
            String getRes = HttpClient.authGet(authUrl, ToolUtil.getSignHeader(uin, signUin));
            if (StringUtils.isNoneBlank(getRes)) {
                result = JSONObject.parseObject(getRes, ResultModel.class);
            } else {
                result.setCode(-3);
                result.setMsg("服务器超时");
            }
        } else {
            result.setCode(-3);
            result.setMsg("服务器超时");
        }
        return result;
    }


    /**
     * 登出
     *
     * @param uin
     * @param signUin
     * @param tin
     * @return
     */
    @RequestMapping(value = "/logout")
    @ResponseBody
    public Object logout(String uin, String signUin, String tin,HttpServletRequest httpRequest) {
        ResultModel result = new ResultModel();
        if (StringUtils.isAnyBlank(uin, signUin, tin)) {
            result.setCode(-2);
            result.setMsg("参数不能为空");
            return result;
        }
        HttpSession session = httpRequest.getSession();
        ResultModel r  = (ResultModel)session.getAttribute("accesssvr");
        JSONArray jsonArray = (JSONArray)(r.getResult());
        JSONObject jsonObject = jsonArray.getJSONObject(0);
        Map<String, String> params = new HashMap<>();
        params.put("uin", uin);
        params.put("tin", tin);
        String postUrl = "http://"+jsonObject.get("host")+ ":" +jsonObject.get("http_port") + "/service/user/logout";
        String postRes = HttpClient.authPost(postUrl, params, ToolUtil.getSignHeader(uin, signUin));
        if (StringUtils.isNotBlank(postRes)) {
            result = JSONObject.parseObject(postRes, ResultModel.class);
        } else {
            result.setCode(-3);
            result.setMsg("服务器超时");
        }
        return result;
    }


    /**
     * 修改用户信息
     *
     * @param uin
     * @param signUin
     * @return
     */
    @RequestMapping(value = "/modify")
    @ResponseBody
    public Object modify(String uin, String signUin, String nickname, String sex, String photo, String addr, String country, String postcode,HttpServletRequest httpRequest) {
        ResultModel result = new ResultModel();
        if (StringUtils.isAnyBlank(uin, signUin)) {
            result.setCode(-2);
            result.setMsg("参数不能为空");
            return result;
        }
        HttpSession session = httpRequest.getSession();
        ResultModel r  = (ResultModel)session.getAttribute("accesssvr");
        JSONArray jsonArray = (JSONArray)(r.getResult());
        JSONObject jsonObject = jsonArray.getJSONObject(0);
        Map<String, String> params = new HashMap<>();
        params.put("uin", uin);
        params.put("nickname", nickname);
        params.put("sex", sex);
        params.put("photo", photo);
        params.put("addr", addr);
        params.put("country", country);
        params.put("postcode", postcode);
        String postUrl = "http://"+jsonObject.get("host")+ ":" +jsonObject.get("http_port") + "/service/user/modify";
        String postRes = HttpClient.authPost(postUrl, params, ToolUtil.getSignHeader(uin, signUin));
        if (StringUtils.isNotBlank(postRes)) {
            result = JSONObject.parseObject(postRes, ResultModel.class);
        } else {
            result.setCode(-3);
            result.setMsg("服务器超时");
        }
        return result;
    }

}