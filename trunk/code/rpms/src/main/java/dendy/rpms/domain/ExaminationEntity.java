package dendy.rpms.domain;

import dendy.rpms.utils.CustomDateSerializerYMDHM;
import dendy.rpms.utils.CustomDateSerializerYMDHMS;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * <p>Created by Dendy on 2014/9/8.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class ExaminationEntity {
    private Long id;
    // 动物id
    private Long animalId;
    // 动物芯片号
    private String animalChipCode;
    private String updateUserName;
    private String createUserName;
    // 体重（kg）
    private Float weight;
    // 吻长（从鼻尖到头顶）
    private Float coutourLength;
    // 体长（从头顶到尾跟）
    private Float bodyLength;
    // 耳长
    private Float earLength;
    // 尾长
    private Float tailLength;
    // 颈围
    private Float neckGirth;
    // 胸围
    private Float chestGirth;
    // 腹围
    private Float abdominalGirth;
    // 左前肢（从大腿根到脚踝）
    private Float leftFrontLegLength;
    // 左后肢长度（从大腿根到脚踝）
    private Float leftBackLegLength;
    // 体温
    private Float temperature;
    // 体检员
    private String examUser;
    // 体检时间
    private Date examTime;
    // 记录时间
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

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
    }

    public Float getCoutourLength() {
        return coutourLength;
    }

    public void setCoutourLength(Float coutourLength) {
        this.coutourLength = coutourLength;
    }

    public Float getBodyLength() {
        return bodyLength;
    }

    public void setBodyLength(Float bodyLength) {
        this.bodyLength = bodyLength;
    }

    public Float getEarLength() {
        return earLength;
    }

    public void setEarLength(Float earLength) {
        this.earLength = earLength;
    }

    public Float getTailLength() {
        return tailLength;
    }

    public void setTailLength(Float tailLength) {
        this.tailLength = tailLength;
    }

    public Float getNeckGirth() {
        return neckGirth;
    }

    public void setNeckGirth(Float neckGirth) {
        this.neckGirth = neckGirth;
    }

    public Float getChestGirth() {
        return chestGirth;
    }

    public void setChestGirth(Float chestGirth) {
        this.chestGirth = chestGirth;
    }

    public Float getAbdominalGirth() {
        return abdominalGirth;
    }

    public void setAbdominalGirth(Float abdominalGirth) {
        this.abdominalGirth = abdominalGirth;
    }

    public Float getLeftFrontLegLength() {
        return leftFrontLegLength;
    }

    public void setLeftFrontLegLength(Float leftFrontLegLength) {
        this.leftFrontLegLength = leftFrontLegLength;
    }

    public Float getLeftBackLegLength() {
        return leftBackLegLength;
    }

    public void setLeftBackLegLength(Float leftBackLegLength) {
        this.leftBackLegLength = leftBackLegLength;
    }

    public Float getTemperature() {
        return temperature;
    }

    public void setTemperature(Float temperature) {
        this.temperature = temperature;
    }

    public String getExamUser() {
        return examUser;
    }

    public void setExamUser(String examUser) {
        this.examUser = examUser;
    }

    @JsonSerialize(using = CustomDateSerializerYMDHM.class)
    public Date getExamTime() {
        return examTime;
    }

    public void setExamTime(Date examTime) {
        this.examTime = examTime;
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
