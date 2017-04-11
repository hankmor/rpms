package dendy.rpms.utils;

import org.apache.commons.codec.digest.DigestUtils;

import java.io.UnsupportedEncodingException;

/**
 * MD5加密工具
 * 
 * @author Dendy
 * @since 2013年11月26日
 */
public class MD5Util {
	public static String encrypt(String str) {
		// 这里需要自己制定编码,否则会因为机器编码环境不同导致加密字符串不同
		try {
			return DigestUtils.md5Hex(str.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return str;
		}
	}
}
