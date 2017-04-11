package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.domain.HouseTransferEntity;
import dendy.rpms.entity.HouseTransfer;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>Created by Dendy on 2014/8/28.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Repository
public class HouseTransferDao extends BaseDao {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(HouseTransferDao.class);

    //~ Instance fields ================================================================================================

    //~ Methods ========================================================================================================

    /**
     * 添加转移记录
     *
     * @param houseTransfer
     */
    public void add(HouseTransfer houseTransfer) {
        if (houseTransfer == null) return;
        save(houseTransfer);
    }

    /**
     * 获取转移历史记录
     *
     * @param id
     * @return
     */
    public List<HouseTransferEntity> getTransRecords(Long id) {
        if (id == null) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(HouseTransfer.class);
        dc.createAlias("animal", "animal");
        dc.createAlias("houseBySrcHouse", "srcHouse", Criteria.LEFT_JOIN);
        dc.createAlias("houseByDestHouse", "destHouse", Criteria.LEFT_JOIN);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.add(Restrictions.eq("animal.id", id));

        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("srcHouse.id"), "srcHouseId");
        pl.add(Projections.property("srcHouse.numer"), "srcHouseNumber");
        pl.add(Projections.property("destHouse.id"), "destHosueId");
        pl.add(Projections.property("destHouse.numer"), "destHouseNumber");
        pl.add(Projections.property("animal.id"), "animalId");
        pl.add(Projections.property("animal.microchipCode"), "animalChipCode");
        pl.add(Projections.property("updateUser.id"), "updateUserId");
        pl.add(Projections.property("updateUser.name"), "updateUserName");
        pl.add(Projections.property("createUser.id"), "createUserId");
        pl.add(Projections.property("createUser.name"), "createUserName");
        pl.add(Projections.property("zoo"), "zoo");
        pl.add(Projections.property("transType"), "transType");
        pl.add(Projections.property("transTime"), "transTime");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("remark"), "remark");

        dc.setProjection(pl);
        dc.setResultTransformer(Transformers.aliasToBean(HouseTransferEntity.class));
        return findCriteriaAll(dc);
    }
}
