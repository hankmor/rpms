package dendy.rpms.domain;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 动物基因型
 * <p>Created by Dendy on 2014/11/9.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class AnimalGenotypeEntity {
    //~ Static fields/initializers =====================================================================================

    //~ Instance fields ================================================================================================
    private Long id;
    // 电子芯片号
    private String microchipCode;
    // 刺青编号（编号）
    private String tatooCode;
    // 名称
    private String name;
    // 物种
    private String typeName;
    // 基因型列表
    private Map<String, GenotypeInfo> genotypeInfos = new LinkedHashMap<>();

    //~ Methods ========================================================================================================

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Map<String, GenotypeInfo> getGenotypeInfos() {
        return genotypeInfos;
    }

    public void setGenotypeInfos(Map<String, GenotypeInfo> genotypeInfos) {
        this.genotypeInfos = genotypeInfos;
    }

    /**
     * 动物基因型数据
     */
    public class GenotypeInfo {
        private Integer codeA;
        private Integer codeB;
        private String primerNo;

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

        public String getPrimerNo() {
            return primerNo;
        }

        public void setPrimerNo(String primerNo) {
            this.primerNo = primerNo;
        }


    }
}
