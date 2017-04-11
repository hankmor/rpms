package dendy.rpms.constant;

import dendy.rpms.utils.CustomizedPropertyConfig;

/**
 * 系统常量管理类
 *
 * @author Dendy
 * @version 1.0
 * @since 2013-10-9下午1:54:24
 */
public class SystemConst {

    private SystemConst() {
    }

    // 系统 context path 定义
    /**
     * 获取系统context path的key
     */
    public static final String SYSTEM_CONTEXT_PATH_KEY = "ctx";
    /**
     * 系统context path
     */
    public static final String SYSTEM_CONTEXT_PATH = (String) CustomizedPropertyConfig.get("content_path");
    public static final String DEFAULT_PASSWORD = "123456";

    //~=============================== 系统角色信息 ===============================
    /**
     * 超级管理员
     */
    public static final String ROLE_CODE_SUPER_MANAGER = "ROLE_SUPER_MANAGER";
    /**
     * 系统管理员
     */
    public static final String ROLE_CODE_MANAGER = "ROLE_MANAGER";
    /**
     * 饲养员
     */
    public static final String ROLE_CODE_FEEDER = "ROLE_FEEDER";
    /**
     * 医护人员
     */
    public static final String ROLE_CODE_CARE_USER = "ROLE_CODE_CARE_USER";

    //~=============================== 性别 ===============================
    /**
     * 女
     */
    public static final boolean SEX_FEMAIL = false;
    /**
     * 男
     */
    public static final boolean SEX_MAIL = true;

    //~=============================== 圈舍转移类型 ===============================
    /**
     * 转出到外部园区
     */
    public static final int TRANS_OUT_TO_OTHER_ZOO = 0;
    /**
     * 转出到本园区
     */
    public static final int TRANS_OUT_TO_LOCAL_HOUSE = 1;
    /**
     * 从外部园区转入
     */
    public static final int TRANS_IN_FROM_OTHER_ZOO = 2;
    /**
     * 从本园区转入
     */
    public static final int TRANS_IN_FROM_LOCAL_ZOO = 3;

    //~=============================== 动物状态类型 ===============================

    /**
     * 被删除
     */
    public static final Byte ANIMAL_STATUS_DELETE = -1;
    /**
     * 转出到其他园区
     */
    public static final Byte ANIMAL_STATUS_TRANS_OUT = 0;
    /**
     * 在养
     */
    public static final Byte ANIMAL_STATUS_FEEDING = 1;
    /**
     * 死亡
     */
    public static final Byte ANIMAL_STATUS_DEAD = -2;

    /**
     * 临时文件目录
     */
    public static final String FILE_TEMP_PATH = (String) CustomizedPropertyConfig.get("tmp_file_path");

    /**
     * 文件存放路径
     */
    public static final String FILE_SAVE_PATH = (String) CustomizedPropertyConfig.get("file_save_path");

    /**
     * 文件访问url(host)
     */
    public static final String FILE_VISIT_URL = (String) CustomizedPropertyConfig.get("file_visit_url");

    /**
     * 图片
     */
    public static final byte ATTA_TYPE_PIC = 0;
    /**
     * 音频
     */
    public static final byte ATTA_TYPE_AUDIO = 1;
    /**
     * 视频
     */
    public static final byte ATTA_TYPE_VIDIO = 2;
    /**
     * 其他
     */
    public static final byte ATTA_TYPE_OTHER = 3;

    /**
     * 外观情况
     */
    public static final byte EXAM_ATTA_TYPE_FACADE = 0;

    /**
     * 受伤情况
     */
    public static final byte EXAM_ATTA_TYPE_WOUND = 1;
}
