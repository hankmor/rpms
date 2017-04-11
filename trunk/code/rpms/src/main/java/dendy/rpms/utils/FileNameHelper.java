package dendy.rpms.utils;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.UUID;

/**
 * 文件名工具类，扩展common-io的FileNameUtils.
 * <p>Created by Dendy on 2014/8/7.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class FileNameHelper extends FilenameUtils {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(FileNameHelper.class);

    //~ Instance fields ================================================================================================

    //~ Methods ========================================================================================================

    /**
     * 根据uuid获取用户名，去掉uuid中的"-".
     * <p>如果参数ext为空,则仍然返回格式化的uuid</p>
     * 例如：
     * <pre>
     *      uuidFileName("mp3") -> 8bdec218445e4a06b7b335e1f4205568.mp3
     *      uuidFileName("") -> 8bdec218445e4a06b7b335e1f4205568
     * </pre>
     *
     * @param ext 扩展名
     * @return 文件名
     */
    public static String uuidFileName(String ext) {
        if (StringUtils.hasLength(ext))
            ext = "." + ext;
        String uuid = UUID.randomUUID().toString();
        return uuid.replaceAll("-", "") + ext;
    }

    /**
     * 根据当前时间戳获取用户名.
     * <p>如果参数ext为空,则仍然返回当前的时间戳</p>
     * 例如：
     * <pre>
     *      timestampFileName("mp3") -> 20140807101540233.mp3
     *      timestampFileName("") -> 20140807101540233
     * </pre>
     *
     * @param ext 扩展名
     * @return 文件名
     */
    public static String timestampFileName(String ext) {
        if (StringUtils.hasLength(ext))
            ext = "." + ext;
        return DateFormatUtils.format(new Date(), "yyyyMMddHHmmssS") + ext;
    }
}
