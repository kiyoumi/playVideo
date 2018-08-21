package net.sunniwell.asse.model;

/**
 * 系统用户表结构定义
 *
 * @author: Jeremy Xie
 */
public class UserSystemModel {
    //系统用户uin
    private long uin;
    private String selfid;
    private String nickname;
    private int sex;
    private String mobile;
    private String addr;
    private String email;
    private String photo;
    private int birthday;
    private String sign;
    private String introduction;
    private int identity;
    private int fanslevel;
    private int carid;
    private int focuscount;
    private int fanscount;
    private int contribution;
    private long registerutc;

    public long getUin() {
        return uin;
    }

    public void setUin(long uin) {
        this.uin = uin;
    }

    public String getSelfid() {
        return selfid;
    }

    public void setSelfid(String selfid) {
        this.selfid = selfid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getBirthday() {
        return birthday;
    }

    public void setBirthday(int birthday) {
        this.birthday = birthday;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }
    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction= introduction;
    }

    public int getIdentity() {
        return identity;
    }
    public void setIdentity(int identity) {
        this.identity = identity;
    }

    public int getFanslevel() {
        return fanslevel;
    }
    public void setFanslevel(int fanslevel) {
        this.fanslevel = fanslevel;
    }

    public int getCarid() {
        return carid;
    }
    public void setCarid(int carid) {
        this.carid = carid;
    }

    public int getFocuscount() {
        return focuscount;
    }
    public void setFocuscount(int focuscount) {
        this.focuscount = focuscount;
    }

    public int getFanscount() {
        return fanscount;
    }
    public void setFanscount(int fanscount) {
        this.fanscount = fanscount;
    }

    public int getContribution() {
        return contribution;
    }
    public void setContribution(int contribution) {
        this.contribution = contribution;
    }

    public long getRegisterutc() {
        return registerutc;
    }

    public void setRegisterutc(long registerutc) {
        this.registerutc= registerutc;
    }
}
