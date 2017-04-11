package dendy.rpms.domain;

import dendy.rpms.constant.SystemConst;
import dendy.rpms.utils.CustomDateSerializerYMDHMS;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.springframework.util.StringUtils;

import java.util.Date;

/**
 * 附件管理
 *
 * @author Dendy
 * @since 14-2-18
 */
public class AttaEntity {
    private long id;
    // 修改人
    private String updateUserName;
    // 上传人
    private String uploadUserName;
    // 显示名称
    private String name;
    // 文件存储名称
    private String fileName;
    // 存储路径
    private String path;
    // 访问路径
    private String url;
    // 文件大小，带单位
    private Long size;
    // 文件大小
    private String sizeText;
    // 类型
    private Byte type;
    // 描述及说明
    private String description;
    // 上传时间
    private Date uploadTime;
    // 修改时间
    private Date updateTime;
    // 备注
    private String remark;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUpdateUserName() {
        return updateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        this.updateUserName = updateUserName;
    }

    public String getUploadUserName() {
        return uploadUserName;
    }

    public void setUploadUserName(String uploadUserName) {
        this.uploadUserName = uploadUserName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getPath() {
        return path;
    }

    public String getSizeText() {
        if (size != null) {
            if (this.size < 1024 * 1024) {
                // 扩大100倍，精度
                float tmp = size * 100 / 1024;
                return String.format("%.2fKB", tmp / 100);
            } else {
                // 扩大100倍，精度
                float tmp = size * 100 / (1024 * 1024);
                return String.format("%.2fM", tmp / 100);
            }
        }
        return null;
    }

    public void setSizeText(String sizeText) {
        this.sizeText = sizeText;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public Byte getType() {
        return type;
    }

    public void setType(Byte type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @JsonSerialize(using = CustomDateSerializerYMDHMS.class)
    public Date getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }

    @JsonSerialize(using = CustomDateSerializerYMDHMS.class)
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUrl() {
        if (StringUtils.hasLength(path))
            return SystemConst.FILE_VISIT_URL + path + fileName;
        return null;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
