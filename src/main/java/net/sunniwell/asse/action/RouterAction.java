package net.sunniwell.asse.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Administrator on 2017/5/2.
 */
@Controller
public class RouterAction {

    /**
     * 收藏页
     *
     * @return
     */
    @RequestMapping(value = "/collect")
    public Object collect() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("collect");
        return mav;
    }

    /**
     * 详情页
     *
     * @return
     */
    @RequestMapping(value = "/detail")
    public Object detail() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("detail");
        return mav;
    }

    /**
     * 历史页
     *
     * @return
     */
    @RequestMapping(value = "/history")
    public Object history() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("history");
        return mav;
    }

    /**
     * 主页
     *
     * @return
     */
    @RequestMapping(value = "/")
    public Object home() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("home");
        return mav;
    }
    /**
     * 列表页
     *
     * @return
     */
    @RequestMapping(value = "/list")
    public Object list() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("list");
        return mav;
    }

    /**
     * 登录注册页
     *
     * @return
     */
    @RequestMapping(value = "/login")
    public Object login() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login");
        return mav;
    }

    /**
     * 播放页
     *
     * @return
     */
    @RequestMapping(value = "/play")
    public Object play() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("play");
        return mav;
    }

    /**
     * 用户页
     *
     * @return
     */
    @RequestMapping(value = "/myCenter")
    public Object myCenter() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("myCenter");
        return mav;
    }

    /**
     *搜索
     *
     * @return
     */
    @RequestMapping(value = "/search")
    public Object search() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("search");
        return mav;
    }


}
