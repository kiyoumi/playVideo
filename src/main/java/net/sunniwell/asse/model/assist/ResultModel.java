package net.sunniwell.asse.model.assist;

import com.alibaba.fastjson.JSONObject;

/**
 * 处理结果数据结构类
 *
 * @author Jeremy Xie
 */
public class ResultModel<T> {

    // 结果码
    private int code = 0;
    // 说明
    private String msg = "成功";
    // 结果值
    private T result;

    public ResultModel() {
    }

    public ResultModel(int code, String msg, T result) {
        this.code = code;
        this.msg = msg;
        this.result = result;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getResult() {
        return result;
    }

    public void setResult(T result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return JSONObject.toJSONString(this);
    }
}
