package dendy.rpms.domain;

import dendy.rpms.utils.CustomDateSerializerYMDHMS;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * 引物信息
 *
 * @author Dendy
 * @since 14-2-18
 */
public class PrimerEntity {
    private Long id;
    // 编号
    private String no;
    // 现有基因型数量
    private Long genotypeCnt;
    // 创建人
    private String createUserName;
    // 修改人
    private String updateUserName;
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

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public Long getGenotypeCnt() {
        return genotypeCnt;
    }

    public void setGenotypeCnt(Long genotypeCnt) {
        this.genotypeCnt = genotypeCnt;
    }

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public String getUpdateUserName() {
        return updateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        this.updateUserName = updateUserName;
    }

    @JsonSerialize(using = CustomDateSerializerYMDHMS.class)
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
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
}
