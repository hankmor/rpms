package dendy.rpms.query;

import dendy.rpms.constant.SystemConst;
import dendy.rpms.domain.AnimalEntity;
import dendy.rpms.entity.Animal;
import dendy.rpms.page.ObjectQuery;
import org.apache.poi.util.StringUtil;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.*;
import org.springframework.util.StringUtils;

/**
 * 小熊猫查询对象
 *
 * @author Dendy
 * @since 14-2-20
 */
public class AnimalQuery extends ObjectQuery {
    private String microchipCode;
    private String no;
    private String name;
    private Byte status;
    private Long houseId;
    private Boolean sex;
    /**
     * 自己的id，用于不查询自己
     */
    private Long redPandaId;
    private static final Byte DELTED_STATUS = SystemConst.ANIMAL_STATUS_DELETE;
    private Boolean queryNotInHouse;

    private Boolean queryGenotypes = false;

    // 排序字段，逗号分隔
    private String orderField = "tatooCode";
    // 排序方式，与排序字段一一对应
    private String orderType = "asc";

    @Override
    public ProjectionList projectionList() {
        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("microchipCode"), "microchipCode");
        pl.add(Projections.property("tatooCode"), "tatooCode");
        pl.add(Projections.property("studbookCode"), "studbookCode");
        pl.add(Projections.property("earCode"), "earCode");
        pl.add(Projections.property("lipCode"), "lipCode");
        pl.add(Projections.property("name"), "name");
        pl.add(Projections.property("sex"), "sex");
        pl.add(Projections.property("age"), "age");
        pl.add(Projections.property("birthDate"), "birthDate");
        pl.add(Projections.property("status"), "status");
        pl.add(Projections.property("chipTime"), "chipTime");
        pl.add(Projections.property("type.name"), "typeName");
        pl.add(Projections.property("type.id"), "typeId");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("createUser.name"), "createUserName");
        pl.add(Projections.property("createUser.id"), "createUserId");
        pl.add(Projections.property("updateUser.name"), "updateUserName");
        pl.add(Projections.property("updateUser.id"), "updateUserId");
        pl.add(Projections.property("father.microchipCode"), "fatherChipCode");
        pl.add(Projections.property("father.id"), "fatherId");
        pl.add(Projections.property("mother.microchipCode"), "motherChipCode");
        pl.add(Projections.property("mother.id"), "motherId");
        pl.add(Projections.property("house.numer"), "houseNumber");
        pl.add(Projections.property("house.id"), "houseId");
        pl.add(Projections.property("atta.id"), "photoId");
        pl.add(Projections.property("remark"), "remark");
        pl.add(Projections.property("comeFrom"), "comeFrom");
        return pl;
    }

    @Override
    public Class getDomainClass() {
        return AnimalEntity.class;
    }

    @Override
    public DetachedCriteria getDetachedCriteria() {
        DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
        // 级联查询创建人和最后修改人
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("animalByFather", "father", Criteria.LEFT_JOIN);
        dc.createAlias("animalByMother", "mother", Criteria.LEFT_JOIN);
        dc.createAlias("house", "house", Criteria.LEFT_JOIN);
        dc.createAlias("animalType", "type", Criteria.LEFT_JOIN);
        dc.createAlias("atta", "atta", Criteria.LEFT_JOIN);

        if (queryGenotypes != null) {
            if (queryGenotypes)
                dc.setFetchMode("animalGenotypes", FetchMode.JOIN);
        }

        if (StringUtils.hasLength(microchipCode))
            dc.add(Restrictions.ilike("microchipCode", microchipCode, MatchMode.ANYWHERE));
	    if (StringUtils.hasLength(no))
		    dc.add(Restrictions.ilike("tatooCode", no, MatchMode.ANYWHERE));
        if (StringUtils.hasLength(name))
            dc.add(Restrictions.ilike("name", name, MatchMode.ANYWHERE));
        if (houseId != null)
            dc.add(Restrictions.eq("house.id", houseId));
        if (queryNotInHouse != null) {
            if (queryNotInHouse)
                dc.add(Restrictions.isNull("house"));
            else
                dc.add(Restrictions.isNotNull("house"));
        }
        if (sex != null) {
            dc.add(Restrictions.eq("sex", sex));
        }
        if (status != null)
            dc.add(Restrictions.eq("status", status));
        else
            // 不查询已经被删除的对象
            dc.add(Restrictions.not(Restrictions.eq("status", DELTED_STATUS)));
        // 不查询自己
        if (redPandaId != null)
            dc.add(Restrictions.not(Restrictions.eq("id", redPandaId)));

        String[] orderFields = orderField.split(",");
        String[] orderTypes = orderType.split(",");
        if (orderFields.length != orderTypes.length)
            throw new RuntimeException("query logic excetion.");
        for (int i = 0; i < orderFields.length; i++) {
            dc.addOrder("asc".equalsIgnoreCase(orderTypes[i]) ? Order.asc(orderFields[i]) : Order.desc(orderFields[i]));
        }
        dc.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return dc;
    }

    public String getMicrochipCode() {
        return microchipCode;
    }

    public void setMicrochipCode(String microchipCode) {
        this.microchipCode = microchipCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public Long getHouseId() {
        return houseId;
    }

    public void setHouseId(Long houseId) {
        this.houseId = houseId;
    }

    public Boolean getQueryNotInHouse() {
        return queryNotInHouse;
    }

    public void setQueryNotInHouse(Boolean queryNotInHouse) {
        this.queryNotInHouse = queryNotInHouse;
    }

    public Boolean getSex() {
        return sex;
    }

    public void setSex(Boolean sex) {
        this.sex = sex;
    }

    public Long getRedPandaId() {
        return redPandaId;
    }

    public void setRedPandaId(Long redPandaId) {
        this.redPandaId = redPandaId;
    }

    public String getOrderField() {
        return orderField;
    }

    public void setOrderField(String orderField) {
        this.orderField = orderField;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public Boolean getQueryGenotypes() {
        return queryGenotypes;
    }

    public void setQueryGenotypes(Boolean queryGenotypes) {
        this.queryGenotypes = queryGenotypes;
    }

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
}
