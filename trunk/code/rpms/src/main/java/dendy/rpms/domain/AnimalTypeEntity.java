package dendy.rpms.domain;

import java.util.Date;

/**
 * 动物类型.
 * <p>Created by Dendy on 2014/8/25.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class AnimalTypeEntity {
    private Long id;
    // 修改人
    private String updateUserName;
    // 创建人
    private String createUserName;
    // 类型名称
    private String name;
    // 创建时间
    private Date createTime;
    // 修改时间
    private Date updateTime;
    // 备注
    private String remark;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUpdateUserName() {
        return updateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        this.updateUserName = updateUserName;
    }

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

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
}
