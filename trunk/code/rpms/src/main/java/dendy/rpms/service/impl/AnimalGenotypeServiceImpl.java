package dendy.rpms.service.impl;

import dendy.rpms.dao.AnimalGenotypeDao;
import dendy.rpms.domain.AnimalGenotypeItemEntity;
import dendy.rpms.page.Pager;
import dendy.rpms.page.PagerUtil;
import dendy.rpms.query.AnimalGenotypeQuery;
import dendy.rpms.service.IAnimalGenotypeSerice;
import dendy.rpms.utils.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>Created by Dendy on 2014/11/16.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Service
public class AnimalGenotypeServiceImpl implements IAnimalGenotypeSerice {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(AnimalGenotypeServiceImpl.class);

    //~ Instance fields ================================================================================================
    @Autowired
    private AnimalGenotypeDao animalGenotypeDao;

    //~ Methods ========================================================================================================

    @Override
    public Pager<AnimalGenotypeItemEntity> page(AnimalGenotypeQuery animalGenotypeQuery) {
        Assert.notNull(animalGenotypeQuery, "animalGenotypeQuery object must not be null!");
        int beginNum = PagerUtil.getPageStart(animalGenotypeQuery.getPage(), animalGenotypeQuery.getRows());
        return animalGenotypeDao.findPagerData(animalGenotypeQuery.projectionList(), animalGenotypeQuery.getDomainClass(), animalGenotypeQuery.getDetachedCriteria(), beginNum, animalGenotypeQuery.getRows());
    }
}
