package dendy.rpms.utils;

import org.apache.commons.lang.time.DateFormatUtils;

import java.io.File;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Date;
import java.util.UUID;

/**
 * 系统工具类
 *
 * @author ChengJianLong
 */
public class SystemUtils {
    /**
     * 获取系统绝对路径
     *
     * @return 系统绝对路径
     */
    public static String getSysPath() {
        String filePath = null;
        try {
            URL url = SystemUtils.class.getProtectionDomain().getCodeSource().getLocation();
            filePath = URLDecoder.decode(url.getPath(), "utf-8");
            filePath = filePath.substring(0, filePath.indexOf("WEB-INF"));
            File file = new File(filePath);
            filePath = file.getAbsolutePath();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return filePath;
    }

    /**
     * 按照当前日期生成时间戳
     *
     * @return
     */
    public static String getTimestamp() {
        return DateFormatUtils.format(new Date(), "yyyyMMddHHmmssS");
    }

    /**
     * 返回uuid，仅保留字母
     *
     * @return
     */
    public static String getFormatUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
