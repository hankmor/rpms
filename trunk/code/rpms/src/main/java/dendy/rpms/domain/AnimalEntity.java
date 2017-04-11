package dendy.rpms.domain;

import dendy.rpms.utils.CustomDateSerializerYMDHMS;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * 动物
 *
 * @author Dendy
 * @since 14-2-18
 */
public class AnimalEntity {
    private Long id;
    // 电子芯片号
    private String microchipCode;
    // 刺青编号
    private String tatooCode;
    // 谱系号
    private String studbookCode;
    // 耳号
    private String earCode;
    // 唇号
    private String lipCode;
    // 名称
    private String name;
    // 性别 false-女，true-男
    private Boolean sex;
    // 年龄
    private Integer age;
    // 母亲
    private String motherChipCode;
    // 母亲id
    private Long motherId;
    // 父亲id
    private Long fatherId;
    // 父亲
    private String fatherChipCode;
    // 出生日期
    private Date birthDate;
    // 所在圈舍
    private String houseNumber;
    // 圈舍id
    private Long houseId;
    // 来源
    private String comeFrom;
    // 状态
    private Byte status;
    // 动物类型
    private String typeName;
    // 动物类型id
    private Long typeId;
    // 芯片植入时间
    private Date chipTime;
    // 创建人
    private String createUserName;
    // 创建人id
    private Long createUserId;
    // 修改人
    private String updateUserName;
    // 修改人id
    private Long updateUserId;
    // 创建时间
    private Date createTime;
    // 修改时间
    private Date updateTime;
    // 备注信息
    private String remark;
    // 显示照片id
    private Long photoId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMicrochipCode() {
        return microchipCode;
    }

    public void setMicrochipCode(String microchipCode) {
        this.microchipCode = microchipCode;
    }

    public String getTatooCode() {
        return tatooCode;
    }

    public void setTatooCode(String tatooCode) {
        this.tatooCode = tatooCode;
    }

    public String getStudbookCode() {
        return studbookCode;
    }

    public void setStudbookCode(String studbookCode) {
        this.studbookCode = studbookCode;
    }

    public String getEarCode() {
        return earCode;
    }

    public void setEarCode(String earCode) {
        this.earCode = earCode;
    }

    public String getLipCode() {
        return lipCode;
    }

    public void setLipCode(String lipCode) {
        this.lipCode = lipCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getSex() {
        return sex;
    }

    public void setSex(Boolean sex) {
        this.sex = sex;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getMotherChipCode() {
        return motherChipCode;
    }

    public void setMotherChipCode(String motherChipCode) {
        this.motherChipCode = motherChipCode;
    }

    public String getFatherChipCode() {
        return fatherChipCode;
    }

    public void setFatherChipCode(String fatherChipCode) {
        this.fatherChipCode = fatherChipCode;
    }

    @JsonSerialize(using = CustomDateSerializerYMDHMS.class)
    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getHouseNumber() {
        return houseNumber;
    }

    public void setHouseNumber(String houseNumber) {
        this.houseNumber = houseNumber;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    @JsonSerialize(using = CustomDateSerializerYMDHMS.class)
    public Date getChipTime() {
        return chipTime;
    }

    public void setChipTime(Date chipTime) {
        this.chipTime = chipTime;
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

    public Long getMotherId() {
        return motherId;
    }

    public void setMotherId(Long motherId) {
        this.motherId = motherId;
    }

    public Long getFatherId() {
        return fatherId;
    }

    public void setFatherId(Long fatherId) {
        this.fatherId = fatherId;
    }

    public Long getHouseId() {
        return houseId;
    }

    public void setHouseId(Long houseId) {
        this.houseId = houseId;
    }

    public Long getTypeId() {
        return typeId;
    }

    public void setTypeId(Long typeId) {
        this.typeId = typeId;
    }

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public Long getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Long updateUserId) {
        this.updateUserId = updateUserId;
    }

    public Long getPhotoId() {
        return photoId;
    }

    public void setPhotoId(Long photoId) {
        this.photoId = photoId;
    }

    public String getComeFrom() {
        return comeFrom;
    }

    public void setComeFrom(String comeFrom) {
        this.comeFrom = comeFrom;
    }
}
