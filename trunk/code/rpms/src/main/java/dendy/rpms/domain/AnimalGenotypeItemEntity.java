package dendy.rpms.domain;

import dendy.rpms.utils.CustomDateSerializerYMDHMS;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * <p>Created by Dendy on 2014/11/16.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class AnimalGenotypeItemEntity {
    // 动物id
    private Long animalId;
    // 引物编号
    private String primerNo;
    // codeA
    private Integer codeA;
    // codeB
    private Integer codeB;
    // 创建时间
    private Date createTime;

    public Long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(Long animalId) {
        this.animalId = animalId;
    }

    public String getPrimerNo() {
        return primerNo;
    }

    public void setPrimerNo(String primerNo) {
        this.primerNo = primerNo;
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
}
