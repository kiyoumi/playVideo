package net.sunniwell.asse.util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import net.sunniwell.asse.model.assist.ResultModel;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpSession;
import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * 工具类定义
 *
 * @author: Jeremy Xie
 */
public class ToolUtil {

    /**
     * SHA1加密处理
     *
     * @param decript
     * @return
     */
    public static String SHA1(String decript) {
        try {
            MessageDigest digest = MessageDigest
                    .getInstance("SHA-1");
            digest.update(decript.getBytes());
            byte messageDigest[] = digest.digest();
            // Create Hex String
            StringBuffer hexString = new StringBuffer();
            // 字节数组转换为十六进制数
            for (int i = 0; i < messageDigest.length; i++) {
                String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
                if (shaHex.length() < 2) {
                    hexString.append(0);
                }
                hexString.append(shaHex);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 获取指定路径下的文件
     *
     * @param Path
     * @return
     */
    public static String ReadFile(String Path) {
        BufferedReader reader = null;
        String laststr = "";
        try {
            FileInputStream fileInputStream = new FileInputStream(Path);
            InputStreamReader inputStreamReader = new InputStreamReader(
                    fileInputStream, "UTF-8");
            reader = new BufferedReader(inputStreamReader);
            String tempString = null;
            while ((tempString = reader.readLine()) != null) {
                laststr += tempString;
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return laststr;
    }

    /**
     * 对字符串进行加密
     *
     * @param strSrc  加密字符串
     * @param encName 加密类型，可以使SHA-256
     * @return
     */
    public static String Encrypt(String strSrc, String encName) {
        MessageDigest md = null;
        String strDes = null;
        byte[] bt = strSrc.getBytes();
        try {
            md = MessageDigest.getInstance(encName);
            md.update(bt);
            strDes = bytes2Hex(md.digest()); // to HexString
        } catch (NoSuchAlgorithmException e) {
            System.out.println("签名失败！");
            return null;
        }
        return strDes;
    }

    /**
     * 字节数组转哈希值
     *
     * @param bts
     * @return
     */
    public static String bytes2Hex(byte[] bts) {
        String des = "";
        String tmp = null;
        for (int i = 0; i < bts.length; i++) {
            tmp = (Integer.toHexString(bts[i] & 0xFF));
            if (tmp.length() == 1) {
                des += "0";
            }
            des += tmp;
        }
        return des;
    }

    /**
     * 获取当前时间戳
     *
     * @return
     */
    public static long getNowUtc() {
        return new Date().getTime();
    }

    /**
     * 返回长度为【strLength】的随机数，在前面补0
     *
     * @return
     */
    public static int getFixLenthString(int strLength) {
        Random random = new Random();
        int num = -1 ;
        while(true) {
            num = (int)(random.nextDouble()*(100000 - 10000) + 10000);
            if(!(num+"").contains("0")) break ;
        }
        System.out.println(num);
        return num;
        /*Random rm = new Random();
        // 获得随机数
        double pross = (1 + rm.nextDouble()) * Math.pow(10, strLength);
        // 将获得的获得随机数转化为字符串
        String fixLenthString = String.valueOf(pross);
        // 返回固定的长度的随机数
        return Integer.parseInt(fixLenthString.substring(1, strLength + 1));*/
    }

    public static Map<String, String> getSignHeader(String uin,String signUin) {
        Map<String, String> auth = new HashMap<>();
        long nowUtc = getNowUtc();
        int random = getFixLenthString(5);
        String Sign = Encrypt(signUin + nowUtc + "" + random, "SHA-256");
        auth.put("UIN", uin);
        auth.put("Sign", Sign);
        auth.put("Timestamp", nowUtc + "");
        auth.put("Random", random + "");
        auth.put("Token","");
        return auth;
    }


    /**
     * 读取字节流数据
     *
     * @param is
     * @param contentLen
     * @return
     */
    public static byte[] readBytes(InputStream is, int contentLen) {
        if (contentLen > 0) {
            int readLen = 0;
            int readLengthThisTime = 0;
            byte[] message = new byte[contentLen];
            try {
                while (readLen != contentLen) {
                    readLengthThisTime = is.read(message, readLen, contentLen - readLen);
                    if (readLengthThisTime == -1) {
                        break;
                    }
                    readLen += readLengthThisTime;
                }
                return message;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return new byte[]{};
    }



    /**
     * 获取token鉴权请求头信息，放入map中
     *
     * @param uin
     * @param token
     * @return
     */
    public static Map<String, String> getHeader(String uin, String token) {
        Map<String, String> auth = new HashMap<>();
        auth.put("UIN", uin);
        auth.put("Sign","");
        auth.put("Timestamp","");
        auth.put("Random","");
        auth.put("Token", token);
        return auth;
    }

}
