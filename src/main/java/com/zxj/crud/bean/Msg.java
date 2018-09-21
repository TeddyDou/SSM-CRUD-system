package com.zxj.crud.bean;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * General message class for returning
 */
public class Msg {

    //status code 100-success, 200-fail
    private int code;
    //message content
    private String msg;
    //data to be returned to browser
    private Map<String, Object> extend = new HashMap<>();

    public static Msg success() {
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("success");
        return result;
    }

    public static Msg fail() {
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("fail");
        return result;
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

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public Msg add(String key, Object value) {
        this.extend.put(key, value);
        return this;
    }
}
