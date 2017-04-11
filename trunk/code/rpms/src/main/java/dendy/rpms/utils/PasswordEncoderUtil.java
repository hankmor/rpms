package dendy.rpms.utils;

import org.springframework.security.authentication.encoding.Md5PasswordEncoder;

import java.security.MessageDigest;

/**
 * 密码加密工具
 */
public class PasswordEncoderUtil {

    /**
     * 使用MD5加密密码
     *
     * @param password 密码
     * @param userName 用户名
     *
     * @return 加密后的密码
     */
    public static String encodePassowrd(String password, String userName) {
        Md5PasswordEncoder encoder = new Md5PasswordEncoder();
        return encoder.encodePassword(password, userName);
    }
    
    /**
     * 获得MD5加密密码的方法
     */
    public static String getMD5ofStr ( String origString ) {
        String origMD5 = null;
        try {
            MessageDigest md5 = MessageDigest.getInstance( "MD5" );
            byte [] result = md5.digest( origString.getBytes("UTF-8"));
            origMD5 = byteArray2HexStr( result );
        } catch ( Exception e ) {
            e.printStackTrace();
        }
        return origMD5;
    }
    
    
    /**
     * 提供一个MD5多次加密方法
     */
    public static String getMD5ofStr ( String origString , int times ) {
        String md5 = getMD5ofStr( origString );
        for ( int i = 0; i < times - 1; i++ ) {
            md5 = getMD5ofStr( md5 );
        }
        return getMD5ofStr( md5 );
    }
    
    /**
     * 处理字节数组得到MD5密码的方法
     */
    private static String byteArray2HexStr ( byte [] bs ) {
        StringBuffer sb = new StringBuffer();
        for ( byte b : bs ) {
            sb.append( byte2HexStr( b ) );
        }
        return sb.toString();
    }
    
    /**
     * 字节标准移位转十六进制方法
     */
    private static String byte2HexStr ( byte b ) {
        String hexStr = null;
        int n = b;
        if ( n < 0 ) {
            // 若需要自定义加密,请修改这个移位算法即可
            n = b & 0x7F + 128;
        }
        hexStr = Integer.toHexString( n / 16 ) + Integer.toHexString( n % 16 );
        return hexStr.toUpperCase();
    }

    public static void main(String[] args) {
        String a = "123456";
//        Md5PasswordEncoder encoder = new Md5PasswordEncoder();
//        System.out.println(encoder.encodePassword(a, 4));
//        System.out.println(System.currentTimeMillis());
        String s= PasswordEncoderUtil.getMD5ofStr(a, 4);
        System.out.println(s);
    }
}
