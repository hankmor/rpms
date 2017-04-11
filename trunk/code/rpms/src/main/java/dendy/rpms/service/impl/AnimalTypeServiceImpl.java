package dendy.rpms.service.impl;

import dendy.rpms.dao.AnimalTypeDao;
import dendy.rpms.domain.AnimalTypeEntity;
import dendy.rpms.entity.AnimalType;
import dendy.rpms.entity.User;
import dendy.rpms.page.Pager;
import dendy.rpms.page.PagerUtil;
import dendy.rpms.query.AnimalTypeQuery;
import dendy.rpms.service.IAnimalTypeService;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.UserUtil;
import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * <p>Created by Dendy on 2014/8/26.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Service
public class AnimalTypeServiceImpl implements IAnimalTypeService {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(AnimalTypeServiceImpl.class);

    //~ Instance fields ================================================================================================
    @Autowired
    private AnimalTypeDao animalTypeDao;

    //~ Methods ========================================================================================================

    @Override
    public AnimalType get(Long id) {
        Assert.notNull(id);
        return animalTypeDao.get(id);
    }

    @Override
    public void update(AnimalType animalType) {
        Assert.notNull(animalType);
        User updateUser = UserUtil.getUserModel();
        animalType.setUserByUpdateUser(updateUser);
        animalType.setUpdateTime(new Date());
        animalTypeDao.update(animalType);
    }

    @Override
    public void add(AnimalType animalType) {
        Assert.notNull(animalType);
        User createUser = UserUtil.getUserModel();
        animalType.setUserByCreateUser(createUser);
        animalType.setCreateTime(new Date());
        animalTypeDao.add(animalType);
    }

    @Override
    public void delete(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            animalTypeDao.delete(AnimalType.class, Long.parseLong(idArray[i]));
        }
    }

    @Override
    public Pager<AnimalTypeEntity> page(AnimalTypeQuery animalTypeQuery) {
        Assert.notNull(animalTypeQuery, "animalTypeQuery must not be null!");
        DetachedCriteria dc = animalTypeQuery.getDetachedCriteria();
        int beginNum = PagerUtil.getPageStart(animalTypeQuery.getPage(), animalTypeQuery.getRows());
        return animalTypeDao.findPagerData(animalTypeQuery.projectionList(), animalTypeQuery.getDomainClass(), dc, beginNum, animalTypeQuery.getRows());
    }

    @Override
    public List<AnimalTypeEntity> list() {
        return animalTypeDao.getAll();
    }
}
