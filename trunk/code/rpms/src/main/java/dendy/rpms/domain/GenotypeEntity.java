package dendy.rpms.domain;

import dendy.rpms.utils.CustomDateSerializerYMDHMS;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * <p>Created by Dendy on 2014/9/2.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class GenotypeEntity {
    private Long id;
    private Long updateUserId;
    private String UpdateUserName;
    // 引物id
    private Long primerId;
    // 引物编号
    private String primerNo;
    private Long createUserId;
    private String createUserName;
    // 基因型A
    private Integer codeA;
    // 基因型B
    /*实际上基因型对象上没有codeB,用于显示动物的基因型B*/
    private Integer codeB;
    private Date createTime;
    private Date updateTime;
    private String remark;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Long updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getUpdateUserName() {
        return UpdateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        UpdateUserName = updateUserName;
    }

    public Long getPrimerId() {
        return primerId;
    }

    public void setPrimerId(Long primerId) {
        this.primerId = primerId;
    }

    public String getPrimerNo() {
        return primerNo;
    }

    public void setPrimerNo(String primerNo) {
        this.primerNo = primerNo;
    }

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public Integer getCodeA() {
        return codeA;
    }

    public void setCodeA(Integer codeA) {
        this.codeA = codeA;
    }

    public Integer getCodeB() {
        return codeB;
    }

    public void setCodeB(Integer codeB) {
        this.codeB = codeB;
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
