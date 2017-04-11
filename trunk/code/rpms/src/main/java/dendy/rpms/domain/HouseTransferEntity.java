package dendy.rpms.domain;

import dendy.rpms.utils.CustomDateSerializerYMDHMS;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.springframework.util.StringUtils;

import java.util.Date;

/**
 * <p>Created by Dendy on 2014/8/30.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class HouseTransferEntity {
    private Long id;
    // 原始圈舍id
    private Long srcHouseId;
    // 原始圈舍编号
    private String srcHouseNumber;
    // 动物id
    private Long animalId;
    // 动物芯片号
    private String animalChipCode;
    // 修改人id
    private Long updateUserId;
    // 修改人名称
    private String updateUserName;
    // 创建人id
    private Long createUserId;
    // 创建人名称
    private String createUserName;
    // 目标圈舍id
    private Long destHosueId;
    // 目标圈舍编号
    private String destHouseNumber;
    // 园区（转入时为原始园区，转出为目标园区）
    private String zoo;
    // 转移类型
    private Integer transType;
    // 转移时间
    private Date transTime;
    // 记录时间
    private Date createTime;
    // 修改时间
    private Date updateTime;
    private String remark;

    // 来源
    private String src;
    // 去向
    private String dest;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSrcHouseId() {
        return srcHouseId;
    }

    public void setSrcHouseId(Long srcHouseId) {
        this.srcHouseId = srcHouseId;
    }

    public String getSrcHouseNumber() {
        return srcHouseNumber;
    }

    public void setSrcHouseNumber(String srcHouseNumber) {
        this.srcHouseNumber = srcHouseNumber;
    }

    public Long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(Long animalId) {
        this.animalId = animalId;
    }

    public String getAnimalChipCode() {
        return animalChipCode;
    }

    public void setAnimalChipCode(String animalChipCode) {
        this.animalChipCode = animalChipCode;
    }

    public Long getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Long updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getUpdateUserName() {
        return updateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        this.updateUserName = updateUserName;
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

    public Long getDestHosueId() {
        return destHosueId;
    }

    public void setDestHosueId(Long destHosueId) {
        this.destHosueId = destHosueId;
    }

    public String getDestHouseNumber() {
        return destHouseNumber;
    }

    public void setDestHouseNumber(String destHouseNumber) {
        this.destHouseNumber = destHouseNumber;
    }

    public String getZoo() {
        return zoo;
    }

    public void setZoo(String zoo) {
        this.zoo = zoo;
    }

    public Integer getTransType() {
        return transType;
    }

    public void setTransType(Integer transType) {
        this.transType = transType;
    }

    @JsonSerialize(using = CustomDateSerializerYMDHMS.class)
    public Date getTransTime() {
        return transTime;
    }

    public void setTransTime(Date transTime) {
        this.transTime = transTime;
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

    public String getSrc() {
        return StringUtils.hasLength(srcHouseNumber) ? srcHouseNumber : zoo;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public String getDest() {
        return StringUtils.hasLength(destHouseNumber) ? destHouseNumber : zoo;
    }

    public void setDest(String dest) {
        this.dest = dest;
    }
}
