package net.sunniwell.asse.model;

/**
 * 错误信息数据结构定义
 *
 * @author: Jeremy Xie
 */
public class ErrorModel {
    private int errcode;

    private String errmsg;

    public int getErrcode() {
        return errcode;
    }

    public void setErrcode(int errcode) {
        this.errcode = errcode;
    }

    public String getErrmsg() {
        return errmsg;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }

    @Override
    public String toString() {
        return "ErrorBean [errcode=" + errcode + ", errmsg=" + errmsg + "]";
    }
}
